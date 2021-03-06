# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

### Color definitions
# Color format codes
Regular="0"
Bold="1"

# Color codes
None="0"
Black="30"
Red="31"
Green="32"
Yellow="33"
Blue="34"
Purple="35"
Cyan="36"
White="37"

# Colors
CDefault="\[\033[${None}m\]"
CBlack="\[\033[${Regular};${Black}m\]"
CRed="\[\033[${Regular};${Red}m\]"
CGreen="\[\033[${Regular};${Green}m\]"
CYellow="\[\033[${Regular};${Yellow}m\]"
CBlue="\[\033[${Regular};${Blue}m\]"
CPurple="\[\033[${Regular};${Purple}m\]"
CCyan="\[\033[${Regular};${Cyan}m\]"
CWhite="\[\033[${Regular};${White}m\]"
CBoldBlack="\[\033[${Bold};${Black}m\]"
CBoldRed="\[\033[${Bold};${Red}m\]"
CBoldGreen="\[\033[${Bold};${Green}m\]"
CBoldYellow="\[\033[${Bold};${Yellow}m\]"
CBoldBlue="\[\033[${Bold};${Blue}m\]"
CBoldPurple="\[\033[${Bold};${Purple}m\]"
CBoldCyan="\[\033[${Bold};${Cyan}m\]"
CBoldWhite="\[\033[${Bold};${White}m\]"

# Show branch in git repository directiories
source ~/git-prompt.sh

# Find existing SSH agent
source ~/ssh-find-agent.sh
if [ ! -z "${SSH_AUTH_SOCK}" ]; then
	eval $(ssh-find-agent)
fi

# Show kubernetes namespace
source ~/kube-ps1.sh
KUBE_PS1_PREFIX=" ("
KUBE_PS1_SYMBOL_USE_IMG=true
kubeoff

if [ "$(hostname)" = "localhost.localdomain" ]; then
	PS_HOSTNAME=''
else
	PS_HOSTNAME='@\h'
fi

# Custom shell prompt (red for root, green for other users)
if [[ $EUID -eq 0 ]]; then
	PS1="${CBoldRed}\$?${CBoldWhite}\$(kube_ps1)${CBoldYellow}\$(__git_ps1) ${CBoldRed}\u${PS_HOSTNAME} ${CBoldCyan}[\w]${CDefault}# "
else
	PS1="${CBoldRed}\$?${CBoldWhite}\$(kube_ps1)${CBoldYellow}\$(__git_ps1) ${CBoldGreen}\u${PS_HOSTNAME} ${CBoldCyan}[\w]${CDefault}$ "
fi

# Custom ls colors
LS_ARCHIVE_COLORS="*.tar.gz=${Bold};${Red}:*.tgz=${Bold};${Red}:*.xz=${Bold};${Red}:*.tar=${Bold};${Red}:*.zip=${Bold};${Red}:*.tar.bz2=${Bold};${Red}"`
    `":*.tbz2=${Bold};${Red}:*.rar=${Bold};${Red}:*.rpm=${Bold};${Red}"
export LS_COLORS="di=${Bold};${Blue}:ex=${Bold};${Green}:${LS_ARCHIVE_COLORS}"

# Better directory listings
alias la="ls -lAh --group-directories-first"

# Table of mounted partitions
alias lmnt="mount | column -t"

alias clang="clang -fcolor-diagnostics"
alias clang++="clang++ -fcolor-diagnostics"

# Create empty cpp and h file
ctouch() {
    touch "$1.cpp" "$1.h"
}

# Enable quick directory navigation (e.g. 'cd /etc' can be just written as '/etc')
shopt -s autocd

# Check for minor errors while navigating through directories and completion
shopt -s cdspell
shopt -s dirspell

# Multiline command history
shopt -s cmdhist
shopt -s lithist

# Allows usage of ** as wildcard for 0-N subdirectories
shopt -s globstar

# Universal extractor
complete -f -X '!*.@(tar.gz|tgz|tar.bz2|tbz2|xz|tar|zip|rar|7z|bz2)' extract
extract() {
    if [ ! -r $1 ]; then
        echo "File '$1' not found" >&2
    fi

    case $1 in
        *.tar.gz)   tar -xzvf $1    ;;
        *.tgz)      tar -xzvf $1    ;;
        *.tar.bz2)  tar -xjvf $1    ;;
        *.tbz2)     tar -xjvf $1    ;;
        *.xz)       xz -dvk $1      ;;
        *.tar)      tar -xvf $1     ;;
        *.zip)      unzip $1        ;;
        *.rar)      unrar x "$1"    ;;
        *.7z)       7za x $1        ;;
        *.bz2)      bunzip2 -vk $1  ;;
        *)          echo "Invalid file format" >&2  ;;
    esac
}

# Turn off bell
set bell-style none

# Colored man pages using 'most'
export PAGER="most -s"

# Rich history buffer
export HISTSIZE=10000
export HISTFILESIZE=20000

# Set default editor to vim
export EDITOR="vim"

# Auto-completion of file formats
complete -f -X '!*.@(pdf|PDF)' qpdfview
complete -f -X '!*.@(mp4|MP4|avi|AVI|mkv|MKV|wmv|WMV|m4v|M4V|flv|FLV)' vlc

# Run cgdb/gdb of given program with given program and parameters
debug() {
    if [ -z $GDB ]; then
        GDB=`command -v cgdb >/dev/null && echo 'cgdb' || echo 'gdb'`
    fi
    $GDB -ex 'b main' \
        -ex 'run' \
        --args "$@"
}

# Run program under cgdb/gdb and just print stack backtrace
backtrace() {
    gdb -batch \
        -ex 'handle SIG33 pass nostop noprint' \
        -ex 'run' \
        -ex 'backtrace full' \
        -ex 'quit' \
        --args "$@"
}

# Show xxd hex bytes grouped by 1
alias xd="xxd -g1"

# Valgrind for memory leaks
leaks() {
    valgrind --tool=memcheck --leak-check=full "$@"
}

# Valgrind for invalid memory accesses
memcheck() {
	valgrind --tool=memcheck "$@"
}

# Valgrind for gdb debugging
leaksdebug() {
	valgrind --vgdb=yes --vgdb-error=0 "$@"
}

# gdb for valgrind debugging
debugleaks() {
	gdb -ex 'target remote | vgdb' \
		--args "$@"
}

# Copy to clipboard from terminal
alias copy="xclip -selection clipboard"
