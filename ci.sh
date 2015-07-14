#!/bin/bash
ls
cd boats
xvfb-run ----server-args="10x10x24" bash -c "gnuradio-companion boats.grc  & sleep 10; xdotool  key --clearmodifiers Print ; sleep 1; xdotool key --clearmodifiers Right BackSpace BackSpace BackSpace BackSpace Return; sleep 2; xdotool key --clearmodifiers Ctrl+q"
mkdir -p ~/artifacts/mog_grc_fun/build
mv boats.png ~/artifacts/mog_grc_fun/build/
