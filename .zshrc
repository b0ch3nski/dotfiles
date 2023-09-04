# general ZSH config
setopt inc_append_history share_history hist_ignore_all_dups auto_cd auto_pushd pushd_ignore_dups extended_glob no_glob_dots complete_in_word hash_list_all no_clobber prompt_subst no_beep print_exit_value

bindkey -v
bindkey '^H' backward-kill-word

zstyle :compinstall filename '~/.zshrc'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' completer _expand _expand_alias _complete _correct _approximate _files
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true
zstyle ':completion:*' use-cache true

autoload -Uz compinit
compinit

HISTFILE=~/.histfile
HISTSIZE=50000
SAVEHIST="${HISTSIZE}"
HISTORY_IGNORE="(ls|ll|cd|pwd|kill)"

# fancy functions
cat-clip() { [[ -f "${1}" ]] && (cat "${1}" | xsel -ib) || echo "${1}: No such file"; }

hex() { [[ -n "${1}" ]] && printf "%x\n" $1 || print "Usage: hex <number-to-convert>" }

min() { printf "%s\n" "${@:2}" | sort "${1}" | head -n1; }

max() { min "${1}r" "${@:2}"; }

# general aliases
alias chgrp="chgrp --preserve-root"
alias chmod="chmod --preserve-root"
alias chown="chown --preserve-root"
alias config="git --git-dir=${HOME}/.dotfiles/ --work-tree=${HOME}/"
alias cp="cp --interactive --verbose"
alias df="df --print-type --human-readable"
alias diff="diff --color=always"
alias du="du --total --summarize --time --human-readable"
alias egrep="egrep --color=always"
alias fgrep="fgrep --color=always"
alias free="free --human"
alias grep="grep --color=always"
alias ifaces="ip -o -4 addr | awk '{ print \$2,\$4 }' | cut -d/ -f 1 | column -s ' ' -t"
alias ll="exa --all --long --classify --group --modified --header --time-style=long-iso --group-directories-first"
alias lln="ll --sort=newest"
alias llo="ll --sort=oldest"
alias lls="ll --sort=size"
alias ln="ln --interactive --verbose"
alias ls="exa --all --classify --group-directories-first"
alias lsblk="lsblk --all --tree --paths --fs --discard"
alias mkdir="mkdir --parents --verbose"
alias mv="mv --interactive --verbose"
alias ping="ping -c 5"
alias pingg="ping google.com"
alias q="clear"
alias :q="exit"
alias rmdir="rmdir --parents --verbose"
alias rm="rm -I --verbose --preserve-root --one-file-system"
alias scrot="scrot --count --delay 3 '/tmp/screen_%Y-%m-%d_%T.png'"
alias tree="ll --tree"
alias unmount="umount"

# pacman aliases
alias p="sudo bauerbill"
alias pm="pacman"
alias update="p -Syy"
alias upgrade="p -Syyu --aur"
alias install="p -S --aur"
alias installpkg="p -U"
alias uninstall="p -Rns"
alias reposearch="pm -Ss"
alias localsearch="pm -Qs"
alias repoinfo="pm -Si"
alias localinfo="pm -Qi"
alias listlocal="pm -Qe"
alias listlocalexp="comm -23 <(pm -Qqen | sort) <(pm -Qqg base base-devel | sort -u)"
alias listfiles="pm -Ql"
alias listaur="pm -Qm"
alias pacorph="(pacman -Qdtq || true) | xargs -r sudo pacman -Rns --noconfirm"
alias pacnew="(find / -regextype posix-extended -regex '.+\.pac(new|save|orig)' 2> /dev/null) || true"

# git aliases
alias gita="git add"
alias gitb="git branch"
alias gitc="git commit --signoff"
alias gitca="git commit --amend"
alias gitch="git checkout"
alias gitcl="git clone"
alias gitcp="git cherry-pick"
alias gitd="git diff --submodule"
alias gitds="git diff --submodule --staged"
alias gitf="git fetch"
alias giti="git init"
alias gitl="git log --full-history --all"
alias gitll="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n'' %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"
alias gitm="git merge"
alias gitpl="git pull"
alias gitps="git push"
alias gitr="git rebase"
alias gitrv="git revert"
alias gits="git status"
alias gitsh="git show"

# docker aliases
alias doccomp="docker-compose"
alias docimg="docker images"
alias docip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"
alias doclab="docker inspect --format '{{ .Config.Labels }}'"
alias doclog="docker logs --follow"
alias docps="docker ps --all | less -S"
alias docrm="docker rm --force --volumes"
alias docrmall="docker ps --all --quiet | xargs -r docker rm --force --volumes"
alias docrmi="docker rmi --force"
alias doccln="docker container prune --force"
alias docimgcln="docker image prune --force"
alias docvolcln="docker volume prune --force"
alias docclnall="docker system prune --force --volumes"

# includes
if [ -f "/usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme" ] && [ "${TERM}" != "linux" ]; then
  POWERLEVEL9K_MODE="nerdfont-complete"
  source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

  POWERLEVEL9K_PROMPT_ADD_NEWLINE="true"
  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
  POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status time)
  POWERLEVEL9K_DIR_SHOW_WRITABLE="true"
fi

if [ -f "/usr/share/fzf/key-bindings.zsh" ] && [ -f "/usr/share/fzf/completion.zsh" ]; then
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/fzf/completion.zsh

  export FZF_DEFAULT_OPTS="--height 40% --cycle --color=bg+:6,prompt:1,gutter:-1"
  export FZF_DEFAULT_COMMAND="rg --files --no-ignore --hidden"
fi

[ -f "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f "/usr/share/doc/pkgfile/command-not-found.zsh" ] && source /usr/share/doc/pkgfile/command-not-found.zsh
[ -f "/opt/google-cloud-cli/completion.zsh.inc" ] && source /opt/google-cloud-cli/completion.zsh.inc
