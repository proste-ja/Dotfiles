#!/bin/sh


## Xresources & Xmodmap
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap


## Merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi


## Start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi


## Mouse & Blank monitor
xset m 20/1 0
#xset s blank
xset s off
xset dpms 0 0 600


## Autostart
/usr/bin/lxpolkit &
#xrandr  --output HDMI-0 --off --output DVI-I-1 --auto &
#numlockx &
#sh $HOME/.config/i3/Scripts/scripts/firefox-sync &

#exec i3 --shmlog-size 0
#exec startlxde
exec i3 --shmlog-size 0
