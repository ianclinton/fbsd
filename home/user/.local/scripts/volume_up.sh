#!/bin/sh

# if mute file exists get volume from that
if test -f "/tmp/vol.tmp"
then
	read VOL_CURRENT < /tmp/vol.tmp
	rm /tmp/vol.tmp
else
	# cut -d splits string on your delimiter -f is the section you want
	VOL_CURRENT=$(mixer | grep vol | cut -d':' -f 2)
fi

VOL_REQUIRED=$(($VOL_CURRENT + 1))

mixer -s vol $VOL_REQUIRED

