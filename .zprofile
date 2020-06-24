umask 077

[ -f "/etc/profile.d/proxy.sh" ] && source /etc/profile.d/proxy.sh
[ -f "/etc/profile.d/envs.sh" ] && source /etc/profile.d/envs.sh

export GOPATH="/data/workspace/golang"
export PATH="${GOPATH}/bin:${HOME}/bin:${PATH}"

# start X on login
if systemctl -q is-active graphical.target && [ -z ${DISPLAY} ] && [ ${XDG_VTNR} -eq 1 ]; then
    exec startx
fi
