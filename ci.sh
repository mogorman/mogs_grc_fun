#!/bin/bash
ls
cd boats
xvfb-run --server-args=" -screen 0 10x10x24" bash -c "gnuradio-companion boats.grc  & sleep 10; xdotool  key --clearmodifiers Print ; sleep 1; xdotool key --clearmodifiers Right BackSpace BackSpace BackSpace BackSpace Return; sleep 2; xdotool key --clearmodifiers Ctrl+q"
mkdir -p ~/artifacts/mogs_grc_fun/build
mv boats.png ~/artifacts/mogs_grc_fun/build/
cd ..

cd salt_test
xvfb-run --server-args="-screen 0 10x10x24" bash -c "gnuradio-companion salt_test.grc  & sleep 10; xdotool  key --clearmodifiers Print ; sleep 1; xdotool key --clearmodifiers Right BackSpace BackSpace BackSpace BackSpace Return; sleep 2; xdotool key --clearmodifiers Ctrl+q"
mv salt_test.png ~/artifacts/mogs_grc_fun/build/
cd ..
echo it works?
cd tutorial_test
mkdir -p ~/.gnuradio
echo "[grc]" > ~/.gnuradio/config.conf
echo "local_blocks_path=../gr-tutorial/grc/" >> ~/.gnuradio/config.conf
xvfb-run --server-args="-screen 0 10x10x24" bash -c "gnuradio-companion tutorial_test.grc  & sleep 10; xdotool  key --clearmodifiers Print ; sleep 1; xdotool key --clearmodifiers Right BackSpace BackSpace BackSpace BackSpace Return; sleep 2; xdotool key --clearmodifiers Ctrl+q"
mv tutorial_test.png ~/artifacts/mogs_grc_fun/build/
rm ~/.gnuradio/config.conf
cd ..

cd fm_transmit
mkdir -p ~/.gnuradio
echo "[grc]" > ~/.gnuradio/config.conf
echo "local_blocks_path=../gr-tutorial/grc/" >> ~/.gnuradio/config.conf
xvfb-run --server-args="-screen 0 10x10x24" bash -c "gnuradio-companion fm_transmit.grc  & sleep 10; xdotool  key --clearmodifiers Print ; sleep 1; xdotool key --clearmodifiers Right BackSpace BackSpace BackSpace BackSpace Return; sleep 2; xdotool key --clearmodifiers Ctrl+q"
mv fm_transmit.png ~/artifacts/mogs_grc_fun/build/
rm ~/.gnuradio/config.conf
cd ..

