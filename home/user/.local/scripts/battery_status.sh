#!/bin/sh

CHARGE_STATUS=$(apm | grep -m Line status | sed "s-AC Line status: --")
CHARGE_ICON=""

BAT_PERC="$(apm | grep -m 1 life: | sed 's/Remaining battery life: //g')"
BAT_NUM=$(echo $BAT_PERC |sed "s/%//g")
if [ $BAT_NUM -gt 94 ]
then
	BAT_ICON="" # full battery
elif [ $BAT_NUM -gt 69 ]
then
	BAT_ICON="" # 3/4 full
elif [ $BAT_NUM -gt 44 ]
then
        BAT_ICON="" # 1/2 full
elif [ $BAT_NUM -gt 15 ]
then
        BAT_ICON="" # 1/4 full
else
	BAT_ICON="" # running on empty
fi

if [ $CHARGE_STATUS == "on-line" ]
then
	echo "$CHARGE_ICON $BAT_PERC"
else
	echo "$BAT_ICON $BAT_PERC"
fi
