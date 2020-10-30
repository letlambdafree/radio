#/usr/bin/env bash
#
# bash-completion for radio script
#
# Copyright 2020, Taeseong Ryu <formeu2s@gmail.com>

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License at <http://www.gnu.org/licenses/> for
# more details.

# COMP_WORDS
#     - an array containing all individual words in the current command line.
# COMP_CWORD
#     - an index of the word containing the current cursor position.
# COMPREPLY
#     - an array variable from which Bash reads the possible completions


### TODO
#
# options(-, --)
# column assignment


# set -u # avoid a undeclared variable
PROGRAM_VERSION=0.1



test_print() {
    local arg1="${1:-0}"
    local arg2="$2"
    local arg3="$3"
    local itemsnumber=0
    local format1='\n\e[1;38;5;40m%s item %s\e[0m\n'
    local format2='\n\e[1;38;5;40m%s items %s\e[0m\n'
    local format3='\n\e[1;38;5;220m%s: %s\n\e[1;38;5;240m%s\e[0m'
    printf "$format3" \
           "${FUNCNAME[1]}()'s at $arg1" \
           "$arg2" \
           "$arg3"

    [[ -n $arg3 ]] && itemsnumber=$(wc -l <<< $arg3)
    if (( $itemsnumber == 1 )); then
        printf "$format1" $itemsnumber
    elif (( $itemsnumber > 1 )); then
        printf "$format2" $itemsnumber
    else
        printf "$format1" no
    fi
    return 0
}

_radio_completions() {
    local p_pre_arg="${COMP_WORDS[COMP_CWORD-2]}"
    local pre_arg="${COMP_WORDS[COMP_CWORD-1]}"
    local cur_arg="${COMP_WORDS[COMP_CWORD]}"
    local opt2 s_opt2 l_opt2_1 l_opt2_2
    local opt3 s_opt3 l_opt3_1 l_opt3_2
    local _search
    case ${#COMP_WORDS[@]} in
        2)
            # echo -n "$cur_arg"
            if [[ $cur_arg =~ ^-- ]]; then
                l_opt2_1="--all --group --local --xxx"
                l_opt2_2=" --youtube --test --edit --version --help"
                opt2="$l_opt2_1""$l_opt2_2"
            elif [[ $cur_arg =~ ^-|'' ]]; then
                opt2="-a -g -l -x -y -t -e -v -h"

            fi
            COMPREPLY=( $(compgen -W "$opt2" -- "$cur_arg") )
            ;;

        3)
            # echo -n "$cur_arg"
            if [[ $pre_arg =~ ^(-g|--group)$ ]]; then
                s_opt3="en kr jp mv lt ln lc pl"
                l_opt3_1=" english korean japanese musicvideo"
                l_opt3_2=" livetv livenews livecam playlist"
                opt3="$s_opt3""$l_opt3_1""$l_opt3_2"
            fi
            COMPREPLY=( $(compgen -W "$opt3" -- "$cur_arg") )
            ;;
        4)
            local oIFS="$IFS"
            local IFS=$'\n'
            source "$HOME/git/radio/arr_youtube_search"
            for item in "${!arr_search[@]}"; do
                _search+=( "$item" )
            done
            if [[ $p_pre_arg =~ ^(-y|--youtube)$ ]]; then
                if [[ $pre_arg =~ ^-(c|u|d)$ ]]; then
                    _search=$(printf "%s\n" "${_search[@]}")
                    COMPREPLY=( $(compgen -W "$_search" -- "$cur_arg") )
                fi
            fi
                IFS="$oIFS"
            ;;
    esac
    return 0
}



complete -F _radio_completions radio
