#!/usr/bin/env bash
##
# If not running interactively, don't do anything
[[ $- != *i* ]] && return;

[ -n $PS1 ] && source $HOME/.bash_profile;
