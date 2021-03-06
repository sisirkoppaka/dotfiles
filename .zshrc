# ---[ Keychain ]------------------------------------------------------
keychain --nogui -q ~/.ssh/id_rsa 2>/dev/null &&
source ~/.keychain/localhost-sh

# ---[ Modules ]-------------------------------------------------------
zmodload zsh/complist
autoload -Uz compinit
compinit
zmodload -a zsh/stat stat
zmodload -ap zsh/mapfile mapfile
autoload colors zsh/terminfo

# ---[ Autols ]--------------------------------------------------------
function chpwd() {
	case `pwd` in
	"$HOME/src/git"|"$HOME/src/git/"*|"/tmp") ;;
	*) ls -G -v ;;
	esac
}

# ---[ Save canceled command ]-----------------------------------------
TRAPINT () {
  zle && [[ $HISTNO -eq $HISTCMD ]] && print -rs -- $BUFFER
  return $1
}

# ---[ Shell exports ]-------------------------------------------------
export EDITOR='emacsclient'
export PATH=~/bin:~/.rbenv/bin:~/.cask/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/lib:~/src/linux/tools/perf
export PYTHONPATH=~/.local/lib
export GEM_HOME=~/.ruby
export PYTHONSTARTUP=~/.pythonrc
export WORDCHARS='*?[]~&;!#$%^(){}<>'
export MENUCONFIG_COLOR='mono'
export PS_PERSONALITY='linux'

# ---[ set MANPATH ]---------------------------------------------------
export MANPATH=~/share/man:/opt/local/share/manpath:$MANPATH

# ---[ evals ]---------------------------------------------------------
eval "$(rbenv init - 2>/dev/null)"
eval "$(dircolors 2>/dev/null)"
source ~/.opam/opam-init/init.zsh &>/dev/null

# ---[ Perl ]----------------------------------------------------------
export PERL_LOCAL_LIB_ROOT=$PERL_LOCAL_LIB_ROOT:~/.perl5
export PERL_MB_OPT="--install_base $HOME/.perl5"
export PERL_MM_OPT="INSTALL_BASE=$HOME/.perl5"
export PERL5LIB=~/.perl5/lib/perl5:$PERL5LIB
export PATH=~/.perl5/bin:$PATH
export PERLBREW_ROOT=~/.perl5
test -f ~/.perl5/etc/bashrc && source ~/.perl5/etc/bashrc

# ---[ Go ]------------------------------------------------------------
export GOPATH=~/.go
export PATH=$GOPATH/bin:$PATH

function gocd () {
	cd "$GOPATH/src/$1"
}

# ---[ Android SDK/ NDK ]----------------------------------------------
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk
# add Android SDK Tools to the path
export ANDROID_SDK=~/utils/android-sdk-linux
export PATH=$PATH:$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools

# add toolchain to the path
export PATH=$PATH:~/utils/arm-eabi-4.6/bin

# add other custom utilities to the path
export PATH=$PATH:~/utils/bin

# add toolchain to the path
export PATH=$PATH:~/utils/arm-2013.11/bin

# ---[ Aliases ]-------------------------------------------------------
# abbreviations
alias resh='source ~/.zshrc'
alias ll='ls -G -vlha'
alias diff='diff -u'
alias ec='emacsclient'
alias jnettop='sudo jnettop'
alias mountfat="sudo mount -o uid=$USER,gid=$USER,fmask=113,dmask=002"
alias mountl="sudo mount -o loop"
alias umount='sudo umount'
alias rf='rm -rf'
alias chrome='google-chrome-beta'

# pacman aliases
alias pS='sudo pacman -S'
alias pSs='pacman -Ss'
alias pSy='sudo pacman -Sy'
alias pSu='sudo pacman -Syu'
alias pU='sudo pacman -U'
alias pR='sudo pacman -Rs'
alias pQ='pacman -Q'
alias pQl='pacman -Ql'
alias pQi='pacman -Qi'
alias pQo='pacman -Qo'
alias pQs='pacman -Qs'

# cower aliases
alias cS='cower -s'
alias cD='cower -d'
alias cU='cower -u'

# gem and pip aliases
alias gi='gem install'
alias pi='pip install --user'

# tiny helpers
function l () {
	case "$1" in
	recent)
		shift
		ls -G -vt "$@" | head -n 5
		;;
	size)
		shift
		ls -G -vS "$@"
		;;
	esac
	ls -G -v "$@"
}

function g () {
    if test $# = 0; then
	git status
    else
	git "$@"
    fi
}

function x () {
	case "$1" in
	*.tar|*.tar.gz|*.tar.bz2|*.tgz|*.xz)
		tar xvf "$1"
		;;
	*.bz2)
		bunzip2 "$1"
		;;
	*.zip)
		unzip "$1"
		;;
	esac
}

function calc () {
	awk "BEGIN { print $@ }"
}

function m () {
	emacsclient -e "(man \"$*\")" 2>&1 >/dev/null || man "$*"
}

alias rmdup='find . -name "*\ \(1\)*" -exec rm {} \;'
alias entertain='mpv "$(find . -type f -regextype posix-awk -iregex ".*\.(avi|mpg|mpeg|mkv|wmv|dat)$" | sort --random-sort | head -n 1)"'
alias incognito='export HISTFILE=/dev/null'
alias cdtop='cd $(g rp --show-toplevel)'
alias fgrep='find . -print0 | grep -FZz'
alias -g L='| less'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'

# usage: git-make       ;for x86 linux.git build or make -j 8
#    or: git-make prove ;for git.git tests
#    or: git-make um    ;for um linux.git build
#    or: git-make um32  ;for um32 linux.git build
#    or: git-make arm   ;for arm64 linux.git build
function git-make () {
	unset ARCH
	unset SUBARCH
	unset CROSS_COMPILE

	test "true" = "$(g rp --is-inside-work-tree 2>/dev/null)" || return 1
	case "$1" in
	    prove)
		make -j 8 test
		;;
	    um)
		make mrproper
		make defconfig ARCH=um
		make -j 8 ARCH=um
		;;
	    um32)
		make mrproper
		make defconfig ARCH=um SUBARCH=i386
		make -j 8 ARCH=um SUBARCH=i386
		;;
	    arm32-native)
		make mrproper
		make defconfig ARCH=arm32
		make -j 2 ARCH=arm32
		;;
	    arm)
		make mrproper
		make defconfig ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
		make -j 8 ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
		;;
	    android-em)
		if test "$2" = "-i"; then
		    make -j 8 ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi-;
		else
		    make mrproper
		    make goldfish_armv7_defconfig ARCH=arm
		    make -j 8 ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi-
		fi
		;;
	    android-flo)
		if test "$2" = "-i"; then
		    make -j 8 ARCH=arm CROSS_COMPILE=arm-eabi-;
		else
		    make mrproper
		    make flo_defconfig ARCH=arm
		    make -j 8 ARCH=arm CROSS_COMPILE=arm-eabi-;
		fi
		;;
	    sparc32)
		make mrproper
		make defconfig ARCH=sparc CROSS_COMPILE=sparc-leon3-linux-
		make -j 8 ARCH=sparc CROSS_COMPILE=sparc-leon3-linux-
		;;
	    *)
		if test -f Kconfig; then
			make mrproper
			make defconfig ARCH=x86
			make -j 8 ARCH=x86
		else
			make -j 8
		fi
	esac
}

# usage: git-prove-all [<branch>]
function git-prove-all () {
	GIT_SEQUENCE_EDITOR="sed -i '/^pick/aexec make -j 8 test'" git ri ${1-master}
}

# usage: gsh <file>
#    or: gsh <name-to-match>
function gsh () {
	if test $# != 1; then
		return 1
	fi
	if test -f "$1"; then
		sh "$1" -v -i
		return
	fi
	find . -maxdepth 1 -type f -name "*$1*" -exec echo "== {}" \; -exec sh {} \;
}

# usage: reload-completer (git|rustc)
function reload-completer () {
	test $# != 1 && return 1
	unfunction -m _$1\*
	autoload -Uz $^fpath/_$1*(N:t)
}

function - () {
	if test "true" = "$(g rp --is-inside-work-tree 2>/dev/null)"; then
		g co -
	else
		cd - >/dev/null
	fi
}

# ---[ ZSH Options ]---------------------------------------------------
setopt   NO_GLOBAL_RCS NO_FLOW_CONTROL NO_BEEP MULTIOS
setopt   NO_NOMATCH
setopt   LIST_AMBIGUOUS AUTO_LIST AUTO_REMOVE_SLASH
setopt   LIST_PACKED LIST_TYPES
setopt   INC_APPEND_HISTORY EXTENDED_HISTORY SHARE_HISTORY HIST_REDUCE_BLANKS
setopt   HIST_SAVE_NO_DUPS HIST_IGNORE_DUPS HIST_FIND_NO_DUPS HIST_EXPIRE_DUPS_FIRST
setopt   NO_NOTIFY LONG_LIST_JOBS
setopt   AUTO_CD AUTO_PUSHD PUSHD_SILENT
setopt   PROMPT_SUBST

# ---[ History ]-------------------------------------------------------
HISTFILE=~/.zsh-history
HISTSIZE=3000
SAVEHIST=$HISTSIZE

# TODO: how to remove it from the history list?
zshaddhistory () {
    [[ $1 != *dcommit* ]]
}

# ---[ Completion system ]---------------------------------------------
fpath=(~/.zsh/completion $fpath)
test -f ~/.zsh/completion/go.zsh && source ~/.zsh/completion/go.zsh
test -f ~/.zsh/completion/perf.sh && source ~/.zsh/completion/perf.sh

# Hack to complete some aliases
_git_fp () { _git_format_patch; }
_git_sel () { _git_send_email; }
_git_seg () { _git_send_email; }
compdef g=git

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*' matcher-list '+' '+m:{|:lower:|}={|:upper:|}' '+l:|=* r:|=*' '+r:|[._-]=** r:|=**'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' verbose yes
zstyle ':completion:*' insert-tab false
zstyle ':completion:*:files' ignored-patterns '*?.o' '*?~'
zstyle ':completion:*:files' file-sort 'date'
zstyle ':completion:*:default' list-prompt
zstyle ':completion:*:match:*' original only
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 5 )) )'
zstyle ':completion:*:functions' ignored-patterns '_*'

# ---[ ZLE ]-----------------------------------------------------------
history-incremental-search-backward-initial() {
	zle history-incremental-search-backward $BUFFER
}
zle -N history-incremental-search-backward-initial
bindkey '^R' history-incremental-search-backward-initial
bindkey -M isearch '^R' history-incremental-search-backward

# ---[ Prompt ]--------------------------------------------------------
source ~/.zsh/prompt/git-prompt.sh

GIT_PS1_DESCRIBE_STYLE=branch
GIT_PS1_SHOWUPSTREAM=git
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWCOLORHINTS=true
GIT_PS1_STATESEPARATOR=""

precmd () { __git_ps1 "%F{white}%B%n%b%f" ":%F{yellow}%B%~%b%f%(!.#.$) " "|%s" }
