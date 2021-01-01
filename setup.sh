#!/bin/sh

# get packages
pkg update
pkg upgrade
pkg install -y xorg libX11 libXft libXinerama pkgconf doas bash htop vim firefox feh font-awesome xcompmgr transset nnn

# create and edit the doas.conf file
doas_conf="/usr/local/etc/doas.conf"
if [ ! -f $doas_conf ];
then
	echo "# wheel group permissions" >> $doas_conf
	echo "permit persist keepenv :wheel" >> $doas_conf
	echo "permit nopass keepenv $USER" >> $doas_conf
fi

copy_dir() # $1 src_dir
{
	src_dir=$(find $1 -type d -not -path "*.git*" -follow -print)
	# loop through each folder
	for src_folder in $src_dir ; do
		dest_folder=$(echo $src_folder | sed "s-/home/$USER--" | sed "s-fbsd-usr-" | sed "s-user-$USER-")
		files=$(find $src_folder -type f -not -path "*setup.sh*" -maxdepth 1  -print) # files in cur_folder	
		is_for_local=$(echo $src_folder | grep "fbsd/local" | wc -m) # /usr/local
		# make folders and change ownership
		if [ $is_for_local -eq 0 ]
		then
			su -l $USER -c "mkdir -p $dest_folder"
			chown $USER $dest_folder
		else
		mkdir -p $dest_folder
			chown root $dest_folder
		fi
		for file in $files ; do
			dest_file=$(echo "$file" | sed "s-$src_folder-$dest_folder-")
			if [ $is_for_local -eq 0 ]
			then
				su -l $USER -c "ln -f $file $dest_file"
				chown $USER $file
			else
				ln -f $file $dest_file
				chown root $dest_file
			fi
		done
	done
}


copy_dir "/home/$USER/fbsd/"

# get and install suckless utilites
my_suckless()
{
	
	su -l $USER -c "git clone https://github.com/ianclinton/$1 ~/.local/src/$1"
	su -l $USER -c "make clean -C ~/.local/src/$1/ install"
	su -l $USER -c "make clean -C ~/.local/src/$1/"
	su -l $USER -c "rm ~/.local/src/$1/config.h"
}

my_suckless dwm
my_suckless dmenu
my_suckless st
my_suckless slstatus

# check for updates again because switch from quaterly to latest
pkg update
pkg upgrade -y
