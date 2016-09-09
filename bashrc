##
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source /etc/profile
# loading dir_colors
source /usr/share/doc/git-core-doc/contrib/completion/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1
PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
