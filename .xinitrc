#!/bin/sh

sysresources="/etc/X11/xinit/.Xresources"
[ -f "${sysresources}" ] && xrdb -merge "${sysresources}"

sysmodmap="/etc/X11/xinit/.Xmodmap"
[ -f "${sysmodmap}" ] && xmodmap "${sysmodmap}"

userresources="${HOME}/.Xresources"
[ -f "${userresources}" ] && xrdb -merge "${userresources}"

usermodmap="${HOME}/.Xmodmap"
[ -f "${usermodmap}" ] && xmodmap "${usermodmap}"

sysxinit="/etc/X11/xinit/xinitrc.d"
if [ -d "${sysxinit}" ]; then
    for file in ${sysxinit}/?*.sh; do
        [ -x "${file}" ] && source "${file}"
    done
fi

setxkbmap -model pc104 -layout pl

# do not beep
xset b off
xset c off

# keyboard typematic delay and rate
xset r rate 250 30

# turn off screen after 10 min
xset dpms 0 0 600

# enable GnuPG SSH agent
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"

# create Xauthority for Docker containers
xauth nlist "${DISPLAY}" | sed -e "s/^..../ffff/" | xauth -f "${HOME}/.Xauthority-docker" nmerge -

# autostart
/usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &
xss-lock -- alock -auth pam -bg shade &
dunst &
nm-applet &
blueman-applet &
pcmanfm-qt --daemon-mode &
flameshot &

exec i3
