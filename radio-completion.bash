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
# column assignment


# set -u # avoid a undeclared variable
PROGRAM_VERSION=0.1.0



make_youtube_result() {
    local i
    source "$HOME"/git/radio/arr_youtube_result
    for i in "${!arr_result[@]}"; do
        _result+=( "$i" )
    done
    return 0
}

comp_words_2_long() {
    comp2="--all --group --local --xxx --youtube "
    comp2+="--others --test --edit --version --help"
    COMPREPLY=( $(compgen -W "$comp2" -- "$cur_arg") )
    return 0
}

comp_words_2_short() {
    comp2="-a -g -l -x -y -o -t -e -v -h"
    COMPREPLY=( $(compgen -W "$comp2" -- "$cur_arg") )
    return 0
}

comp_words_2() {
    case "$cur_arg" in
        --*     ) comp_words_2_long  ;;
        -* | '' ) comp_words_2_short ;;
    esac
    return 0
}

comp_words_3_group() {
    comp3="en kr jp mv lt ln lc pl "
    comp3+="english korean japanese musicvideo "
    comp3+="livetv livenews livecam playlist"
    COMPREPLY=( $(compgen -W "$comp3" -- "$cur_arg") )
    return 0
}

comp_words_3_youtube_option() {
    comp3="-d -u -U"
    COMPREPLY=( $(compgen -W "$comp3" -- "$cur_arg") )
    return 0
}

comp_words_3_youtube_no_option() {
    make_youtube_result
    oIFS="$IFS"
    IFS=$'\n'
    comp3=$(printf "%s\n" "${_result[@]}")
    COMPREPLY=( $(compgen -W "$comp3" -- "$cur_arg") )
    IFS="$oIFS"
    return 0
}

comp_words_3_youtube() {
    case "$cur_arg" in
        -* ) comp_words_3_youtube_option    ;;
        *  ) comp_words_3_youtube_no_option ;;
    esac
    return 0
}

comp_words_3_others() {
    comp3="-c -C"
    COMPREPLY=( $(compgen -W "$comp3" -- "$cur_arg") )
    return 0
}

comp_words_3() {
    case "$pre_arg" in
        -g | --group   ) comp_words_3_group   ;;
        -y | --youtube ) comp_words_3_youtube ;;
        -o | --others  ) comp_words_3_others  ;;
    esac
    return 0
}

comp_words_4() {
    if [[ $p_pre_arg =~ ^(-y|--youtube)$ ]]; then
        if [[ $pre_arg =~ ^-(u|d)$ ]]; then
            make_youtube_result
            oIFS="$IFS"
            IFS=$'\n'
            comp4=$(printf "%s\n" "${_result[@]}")
            COMPREPLY=( $(compgen -W "$comp4" -- "$cur_arg") )
            IFS="$oIFS"
        fi
    fi
    return 0
}

_radio_completion() {
    local p_pre_arg="${COMP_WORDS[COMP_CWORD-2]}"
    local pre_arg="${COMP_WORDS[COMP_CWORD-1]}"
    local cur_arg="${COMP_WORDS[COMP_CWORD]}"
    local comp2 comp3 comp4
    local _result oIFS
    case "${#COMP_WORDS[@]}" in
        2) comp_words_2 ;;
        3) comp_words_3 ;;
        4) comp_words_4 ;;
    esac
    return 0
}



complete -F _radio_completion radio
