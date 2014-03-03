#!/bin/bash

# Notify immediatly on bg job completion
set -o notify

# Case insensitive autocompletion
shopt -s nocaseglob

# Vim as default editor
export EDITOR=/usr/bin/vim

# To make Vim behave under xterm.
# Thanks, @teoljungberg
stty -ixon

#export TERM=screen-256color

# Plenty big history for searching backwards and doing analysis
export HISTFILESIZE=100000

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|xterm-256color|konsole-256color|screen-256color) color_prompt='yes';;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# Terminal colours (after installing GNU coreutils)
NM="\[\033[0;38m\]" #means no background and white lines
HI="\[\033[0;37m\]" #change this for letter colors
HII="\[\033[0;31m\]" #change this for letter colors
SI="\[\033[0;33m\]" #this is for the current directory
IN="\[\033[0m\]"

if [ "$color_prompt" = 'yes' ]; then
  export PS1="[$NM$HI\u@$HII\h $HI\w${NM}$HII\$(__git_ps1)$HI] $IN"
else
  export PS1="[\u@\h \w] "
fi
unset color_prompt force_color_prompt

