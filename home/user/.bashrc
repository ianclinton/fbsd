#!/usr/bin/env bash

# Transparany
transset -a 0.75
clear

# Load the shell dotfiles
for file in ~/.{bash_prompt,bash_aliases}; do
        [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

