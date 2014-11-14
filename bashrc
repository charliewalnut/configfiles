# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export EDITOR=vim

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color)
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    ;;
*)
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    ;;
esac

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Bring in machine-specific config stuff
if [ -f ~/.bashrc_local ]; then
    . ~/.bashrc_local
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_aliases_local ]; then
    . ~/.bash_aliases_local
fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# chromium stuff
export PATH=$DEPOTTOOLSDIR:$CHROMEDIR/third_party/llvm-build/Release+Asserts/bin:./Tools/Scripts:$PATH

export PATH="$HOME/bin:$PATH"
export PATH="$HOME/gsutil:$PATH"
#export GYP_CHROMIUM_NO_ACTION=1

function android_shell() {
    . build/android/envsetup.sh;
    export CHROMIUM_OUT_DIR=out_android;
    export PS1="${debian_chroot:+($debian_chroot)}\u@\h:\w (ANDROID)\$ ";
    export GYP_DEFINES="$GYP_DEFINES use_goma=1";
    alias gencfgs="time ./build/gyp_chromium -Goutput_dir=out_android";
    alias an="time ninja -C out_android/Debug -j${GOMAJ:-50}";
    alias anr="time ninja -C out_android/Release -j${GOMAJ:-50}";
}

# go stuff
export PATH="$PATH:$GOPATH/bin"
export GOARCH=amd64
export GOOS=linux
export GOPATH="$HOME/gocode"
