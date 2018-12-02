#!/bin/sh

sysresources="/etc/X11/xinit/.Xresources"
[ -f "${sysresources}" ] && xrdb -merge "${sysresources}"

sysmodmap="/etc/X11/xinit/.Xmodmap"
[ -f "${sysmodmap}" ] && xmodmap "${sysmodmap}"

userresources="${HOME}/.Xresources"
[ -f "${userresources}" ] && xrdb -merge "${userresources}"

usermodmap="${HOME}/.Xmodmap"
[ -f "${usermodmap}" ] && xmodmap "${usermodmap}"

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for file in /etc/X11/xinit/xinitrc.d/?*.sh; do
    [ -x "${file}" ] && . "${file}"
  done
  unset file
fi

# turn off screen after 10 min
xset dpms 0 0 600

# enable GnuPG SSH agent
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"

# start LXQT session
exec startlxqt
