#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

trap 'unset I3_RESTORE_SUBPROCESS_SCRIPT' SIGINT # Unset the variable on Ctrl+C as well
[[ -n $I3_RESTORE_SUBPROCESS_SCRIPT ]] && "${I3_RESTORE_SUBPROCESS_SCRIPT}" && unset I3_RESTORE_SUBPROCESS_SCRIPT

source "$HOME/.cache/wal/colors-tty.sh"
if [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z ${BASH_EXECUTION_STRING} ]]; then
  exec fish
fi
