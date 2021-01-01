#!/bin/sh

# background
feh --bg-scale ~/.local/share/backgrounds/aurora.webp &

# compositor
xcompmgr -c &

# autostart programs
st &

# start dwm and slstatus
exec slstatus & 
dwm
