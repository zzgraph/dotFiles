#!/usr/bin/env bash

#.bash_profile


if [[ $COLORTERM == gnome-* && $TERM == xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
    export TERM=gnome-256color;
elif infocmp xterm-256color >/dev/null 2>&1; then
    export TERM=xterm-256color;
fi;

# Loading neseccery RC files from ~/.bashrc.d directory
localRCDirectory=$HOME/.bashrc.d;

declare -a rcFiles=(
                    "$localRCDirectory/aliases"
                    "$localRCDirectory/functions"
                    "$localRCDirectory/paths"
                    "$localRCDirectory/prompt"
                    )

for i in ${!rcFiles[*]}; do
    if [ -e ${rcFiles[$i]} ] && [ -r ${rcFiles[$i]} ]; then
        source ${rcFiles[$i]};
    fi;
done;

unset rcFiles localRCDirectory;
