#!/usr/bin/env bash

#.bash_profile


if [[ $COLORTERM == gnome-* && $TERM == xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
    export TERM=gnome-256color;
#elif [[ ! $COLORTERM == gnome-* && $TERM == xterm ]] && infocmp xterm-256color >/dev/null 2>&1; then
    #    export TERM=xterm-256color;
elif [[ $TERM == eterm-color ]] && infocmp eterm-color >/dev/null 2>&1; then
    export TERM=eterm;
else
    export TERM=$TERM
fi;

# NVM Specific configurations https://github.com/creationix/nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# Loading neseccery RC files from ~/.bashrc.d directory
localRCDirectory=$HOME/.bashrc.d;

declare -a rcFiles=(
                    "$localRCDirectory/aliases"
                    "$localRCDirectory/functions"
                    "$localRCDirectory/paths"
                    # "/etc/profile"
                    "$localRCDirectory/prompt"
                    "$localRCDirectory/npmCompletion"
		    "$localRCDirectory/ngCompletion"
                    )

for i in ${!rcFiles[*]}; do
    if [ -e ${rcFiles[$i]} ] && [ -r ${rcFiles[$i]} ]; then
        source ${rcFiles[$i]};
    fi;
done;

# initializing fasd https://github.com/clvv/fasd
eval "$(fasd --init auto)"

eval $(dircolors -b $HOME/.dir_colors)

# Check for interactive bash and that we haven't already been sourced.
if [ -n "${BASH_VERSION-}" -a -n "${PS1-}" -a -z "${BASH_COMPLETION_COMPAT_DIR-}" ]; then

    # Check for recent enough version of bash.
    if [ ${BASH_VERSINFO[0]} -gt 4 ] || \
       [ ${BASH_VERSINFO[0]} -eq 4 -a ${BASH_VERSINFO[1]} -ge 1 ]; then
        [ -r "${XDG_CONFIG_HOME:-$HOME/.config}/bash_completion" ] && \
            . "${XDG_CONFIG_HOME:-$HOME/.config}/bash_completion"
        if shopt -q progcomp && [ -r /usr/share/bash-completion/bash_completion ]; then
	    if [[ ( -z "$INSIDE_EMACS" || "$EMACS_BASH_COMPLETE" = "t" ) &&\
     -f /usr/share/bash-completion/bash_completion ]]; then
            # Source completion code.
		. /usr/share/bash-completion/bash_completion
	    fi
        fi
    fi

fi


unset rcFiles localRCDirectory;
# less initialization script (sh)

# All less.*sh files should have the same semantics!

if [ -z "$LESSOPEN" ] && [ -x /usr/bin/lesspipe.sh ]; then
    # The '||' here is intentional, see rhbz#1254837.
    export LESSOPEN="||/usr/bin/lesspipe.sh %s"
fi
