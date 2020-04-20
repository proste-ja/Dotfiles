#
# ~/.zprofile
#

#[[ -f ~/.bashrc ]] && . ~/.bashrc
#if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
#  exec startx
#fi

if [[ -z $DISPLAY && ! -e /tmp/.X11-unix/X0 ]]; then
   exec startx
fi


## GnuPG
export GPG_TTY=$(tty1)
export GPG_AGENT_INFO="/usr/bin/pinentry-gtk-2"

# Keychain: ssh-agent autostart
eval $(keychain --eval -Q --quiet id_dsa id_rsa)
