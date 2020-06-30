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

# turn off screen after 10 min
xset dpms 0 0 600

# create Xauthority for Docker containers
xauth nlist "${DISPLAY}" | sed -e "s/^..../ffff/" | xauth -f "${HOME}/.Xauthority-docker" nmerge -

# start i3 window manager
exec i3
