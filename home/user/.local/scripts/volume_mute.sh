#!/bin/sh

# if mute file exists unmute else mute
if test -f "/tmp/vol.tmp"
then
	read VOL_CURRENT < /tmp/vol.tmp
	mixer -s vol $VOL_CURRENT
	rm /tmp/vol.tmp
else
	# sends the current volume to a file to be retrieved when unmuted
	mixer | grep vol | cut -d':' -f 2 >> /tmp/vol.tmp
	mixer -s vol 0
fi

