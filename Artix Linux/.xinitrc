#!/bin/sh
#

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi


#if [ -n "$DISPLAY" ]; then
#    export BROWSER=brave-nightly
#else 
#    export BROWSER=lynx
#fi


#export BROWSER=firefox
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
#export QT_STYLE_OVERRIDE="qt5ct"
#export QT_QPA_PLATFORMTHEME=qt5ct


xset m 20/1 0
#xset s blank
xset s off
xset dpms 0 0 600


[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap
/usr/bin/lxpolkit &
#xrandr  --output HDMI-0 --off --output DVI-I-1 --auto &
numlockx &


exec dbus-launch i3 --shmlog-size 0
