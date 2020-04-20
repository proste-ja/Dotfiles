#!/bin/bash
#export DISPLAY=:0.0
#export XAUTHORITY=/home/${USER}/.Xauthority

Artist=$(mocp -i | grep "Artist:" | sed -e "s/^.*: //")
Title=$(mocp -i | grep "SongTitle:" | sed -e "s/^.*: //")
Album=$(mocp -i | grep "Album:" | sed -e "s/^.*: //")



notify-send "  " "$(echo -en "Interpret: $Artist\nPieseň: $Title\nAlbum: $Album")"

#notify-send --urgency=normal --expire-time=10000 "Interpret: $Artist
#Pieseň: $Title
#Album: $Album"

#notify-send --urgency=normal --expire-time=10000 "Interpret: $Artist"
#notify-send --urgency=normal --expire-time=10000 "Pieseň: $Title"
#notify-send --urgency=normal --expire-time=10000 "Album: $Album"



