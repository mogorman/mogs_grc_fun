#!/usr/bin/env python
#taken from hackrf mailing list
#orginal copyright author  Kevin Reid kpreid at switchb.org 
#https://pairlist9.pair.net/pipermail/hackrf-dev/2015-June/001240.html

import time

from gnuradio import gr
from gnuradio import blocks
from gnuradio import analog
from gnuradio import audio

import osmosdr


class OptionalDriverMixin(object):
    def __init__(self):
        self.driver = None
        # must be set by subclass and contain self.driver
        self.driver_connection = None
    
    def enable_driver(self):
        self.__replace_driver(self.make_driver())
    
    def disable_driver(self):
        din, dout = self.driver_connection
        if din == self.driver:
            replacement = blocks.vector_source_c([])
        elif dout == self.driver:
            replacement = blocks.null_sink(gr.sizeof_gr_complex)
        else:
            raise Exception((self.driver, din, dout))
        self.__replace_driver(replacement)
    
    def __replace_driver(self, replacement):
        self.lock()
        din, dout = self.driver_connection
        self.disconnect(din, dout)
        if din == self.driver:
            din = replacement
        elif dout == self.driver:
            dout = replacement
        else:
            raise Exception((self.driver, din, dout))
        self.connect(din, dout)
        self.driver_connection = (din, dout)
        self.driver = replacement
        self.unlock()


class Rx(gr.top_block, OptionalDriverMixin):
    def __init__(self):
        gr.top_block.__init__(self, type(self).__name__)
        OptionalDriverMixin.__init__(self)
        
        # replace this with actual demodulator
        # this just proves there is data. mind the dc offset.
        sink = audio.sink(device_name='', sampling_rate=48000)
        decim = blocks.keep_one_in_n(gr.sizeof_gr_complex, 167)
        demod = blocks.complex_to_real()
        self.connect(decim, demod, sink)
        
        self.driver = blocks.vector_source_c([])
        self.driver_connection = (self.driver, decim)
        self.connect(*self.driver_connection)
    
    def make_driver(self):
        d = osmosdr.source('hackrf=0')
        # re-set device freq, rate, gain parameters here
        return d


class Tx(gr.top_block, OptionalDriverMixin):
    def __init__(self):
        gr.top_block.__init__(self, type(self).__name__)
        OptionalDriverMixin.__init__(self)
        
        # replace this with actual modulator
        const = analog.sig_source_c(1, analog.GR_CONST_WAVE, 0, 0, 1)
        
        self.driver = blocks.null_sink(gr.sizeof_gr_complex)
        self.driver_connection = (const, self.driver)
        self.connect(*self.driver_connection)
    
    
    def make_driver(self):
        d = osmosdr.sink('hackrf=0')
        d.set_center_freq(909e6)
        # re-set device freq, rate, gain parameters here
        return d


def switch(tb):
    tb.enable_driver()
    print 'enabled', tb
    time.sleep(2.0)
    tb.disable_driver()


t = Tx()
r = Rx()
t.start()
r.start()
while True:
    switch(t)
    switch(r)
