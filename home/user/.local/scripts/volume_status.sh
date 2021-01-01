#!/bin/sh

LEVEL=$(mixer | grep vol | cut -d':' -f 2)
FULL_ICON=""
LOW_ICON=""
OFF_ICON=""
MUTE_ICON=""

if [ $LEVEL -gt 20 ]
then
	ICON=$FULL_ICON
elif [ $LEVEL -gt 0 ]
then
	ICON=$LOW_ICON
else
	ICON=$OFF_ICON 
fi



if test -f "/tmp/vol.tmp"
then
	echo $MUTE_ICON
else
	echo $ICON $LEVEL%
fi
