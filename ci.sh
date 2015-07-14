#!/bin/bash
ls
cd boats
xvfb-run --server-args=" -screen 0 10x10x24" bash -c "gnuradio-companion boats.grc  & sleep 10; xdotool  key --clearmodifiers Print ; sleep 1; xdotool key --clearmodifiers Right BackSpace BackSpace BackSpace BackSpace Return; sleep 2; xdotool key --clearmodifiers Ctrl+q"
mkdir -p ~/artifacts/mogs_grc_fun/build
mv boats.png ~/artifacts/mogs_grc_fun/build/
cd..

cd salt_test
xvfb-run --server-args="-screen 0 10x10x24" bash -c "gnuradio-companion salt_test.grc  & sleep 10; xdotool  key --clearmodifiers Print ; sleep 1; xdotool key --clearmodifiers Right BackSpace BackSpace BackSpace BackSpace Return; sleep 2; xdotool key --clearmodifiers Ctrl+q"
mv salt_test.png ~/artifacts/mogs_grc_fun/build/

