#!/bin/bash
Xvfb :1 -screen 0 1600x900x24 &
DISPLAY=:1.0
export DISPLAY
sleep 4
startxfce4 &
/usr/bin/x11vnc -xrandr -ncache_cr -display :1.0 -usepw -forever &
wait -n
