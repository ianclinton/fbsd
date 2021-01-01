choice=$(echo -e "Speakers\nHeadphones" | dmenu -c -bw 1)
if [ $choice == "Speakers" ]
then
	sysctl hw.snd.default_unit=0
else
	sysctl hw.snd.default_unit=1
fi
