# ===== Directory Movement and Listing =====

# Changing/making/removing directory
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHDMINUS
DIRSTACKSIZE=10

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias -- -='cd -'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

alias md='mkdir -p'
alias rd=rmdir

function d () {
  if [[ -n $1 ]]; then
    dirs "$@"
  else
    dirs -v | head -10
  fi
}
compdef _dirs d

function gd () {
    local directory="$(git rev-parse --show-toplevel 2>/dev/null)"

    if git rev-parse --show-toplevel >/dev/null 2>&1; then
        cd $(git rev-parse --show-toplevel 2>/dev/null)
    else
        echo "Not in a git repo" 1>&2
        return 1
    fi
}

# ----- Configure `ls` -----

# Set default value for `LS_COLORS`
export LS_COLORS='no=00:fi=00:di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;33:su=30;41:sg=30;46:tw=30;42:ow=30;43:or=31;40:mi=31;40:'

# Select a theme to be used for ls coloring from `.zsh/.lscolors`
# Use vivid (https://github.com/sharkdp/vivid) to build themes
ls_theme="$ZDOTDIR/.lscolors/snazzy"
if [[ -f "$ls_theme" ]]; then
    export LS_COLORS=$(cat "$ls_theme")
fi
unset ls_theme

# Detect which `ls` flavor is in use
if ls --color >/dev/null 2>&1; then # GNU `ls`
    alias ls="ls --color"
elif gls >/dev/null 2>&1; then # GNU coreutils
    alias ls="gls --color"
else # OS X `ls`
    export LSCOLORS="exfxcxdxbxegedabagacad"
    alias ls="ls -G"
fi

# Some convenient `ls` aliases
alias la="ls -A"
alias ll="ls -AlhF"
alias l="ls -lhF"
alias lsd="ls -lhd -- */"

# Show me the size (sorted) of only the folders in this directory
alias folders="find . -maxdepth 1 -type d -print | xargs du -shk | sort -rn"
