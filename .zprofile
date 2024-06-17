export GOPATH="/data/.golang"
export PATH="${GOPATH}/bin:${HOME}/bin:${PATH}"

# electron config
export ELECTRON_OZONE_PLATFORM_HINT="auto" ELECTRON_TRASH="gio"

# docker config
export DOCKER_DEFAULT_PLATFORM="linux/amd64" BUILDKIT_PROGRESS="plain"

# vagrant config
export VAGRANT_DEFAULT_PROVIDER="lxc"

# gradle config
export GRADLE_OPTS="-Dorg.gradle.daemon=true -Dorg.gradle.caching=true -Dorg.gradle.parallel=true"

# poetry config
export POETRY_VIRTUALENVS_CREATE=1 POETRY_VIRTUALENVS_IN_PROJECT=1 POETRY_VIRTUALENVS_OPTIONS_NO_PIP=1 POETRY_VIRTUALENVS_OPTIONS_NO_SETUPTOOLS=1

# enable GnuPG SSH agent
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
export GPG_TTY="$(tty)"

# start WM on login
if systemctl -q is-active graphical.target && [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  export XDG_SESSION_TYPE="wayland" XDG_CURRENT_DESKTOP="sway"
  exec sway
fi
