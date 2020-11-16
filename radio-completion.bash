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


### description
#
# COMP_WORDS
#     - an array containing all individual words in the current command line.
# COMP_CWORD
#     - an index of the word containing the current cursor position.
# COMPREPLY
#     - an array variable from which Bash reads the possible completions



### TODO
#
# column assignment



_make_youtube_result() {
    local i
    source "$HOME"/git/radio/arr_youtube_result
    for i in "${!arr_result[@]}"; do
        _result+=( "$i" )
    done
    return 0
}

_comp_2_long() {
    comp_list="--all --group --local --xxx --youtube "
    comp_list+="--others --test --edit --version --help"
    COMPREPLY=( $(compgen -W "$comp_list" -- "$cur_arg") )
    return 0
}

_comp_2_short() {
    comp_list="-a -g -l -x -y -o -t -e -v -h"
    COMPREPLY=( $(compgen -W "$comp_list" -- "$cur_arg") )
    return 0
}

_comp_2() {
    case "$cur_arg" in
        --*     ) _comp_2_long  ;;
        -* | '' ) _comp_2_short ;;
    esac
    return 0
}

_comp_3_group_long() {
    comp_list="english korean japanese musicvideo "
    comp_list+="livetv livenews livecam playlist"
    COMPREPLY=( $(compgen -W "$comp_list" -- "$cur_arg") )
    return 0
}

_comp_3_group_short() {
    comp_list="en kr jp mv lt ln lc pl"
    COMPREPLY=( $(compgen -W "$comp_list" -- "$cur_arg") )
    return 0
}

_comp_3_group() {
    case "$pre_arg" in
        --group ) _comp_3_group_long  ;;
        -g | '' ) _comp_3_group_short ;;
    esac
    return 0
}

_comp_3_youtube_option() {
    comp_list="-d -u -U"
    COMPREPLY=( $(compgen -W "$comp_list" -- "$cur_arg") )
    return 0
}

_comp_3_youtube_no_option() {
    _make_youtube_result
    old_IFS="$IFS"
    IFS=$'\n'
    comp_list=$(printf "%s\n" "${_result[@]}")
    COMPREPLY=( $(compgen -W "$comp_list" -- "$cur_arg") )
    IFS="$old_IFS"
    return 0
}

_comp_3_youtube() {
    case "$cur_arg" in
        -* ) _comp_3_youtube_option    ;;
        *  ) _comp_3_youtube_no_option ;;
    esac
    return 0
}

_comp_3_others_long() {
    comp_list="--color_code --256color_code"
    COMPREPLY=( $(compgen -W "$comp_list" -- "$cur_arg") )
}

_comp_3_others_short() {
    comp_list="-c -C"
    COMPREPLY=( $(compgen -W "$comp_list" -- "$cur_arg") )
}

_comp_3_others() {
    case "$cur_arg" in
        --*     ) _comp_3_others_long  ;;
        -* | '' ) _comp_3_others_short ;;
    esac
    return 0
}

_comp_3() {
    case "$pre_arg" in
        -g | --group   ) _comp_3_group   ;;
        -y | --youtube ) _comp_3_youtube ;;
        -o | --others  ) _comp_3_others  ;;
    esac
    return 0
}

_comp_4() {
    if [[ $pre_pre_arg =~ ^(-y|--youtube)$ ]]; then
        if [[ $pre_arg =~ ^-(u|d)$ ]]; then
            _make_youtube_result
            old_IFS="$IFS"
            IFS=$'\n'
            comp_list=$(printf "%s\n" "${_result[@]}")
            COMPREPLY=( $(compgen -W "$comp_list" -- "$cur_arg") )
            IFS="$old_IFS"
        fi
    fi
    return 0
}

_radio_completion() {
    #
    # main function
    #
    local cur_arg="${COMP_WORDS[COMP_CWORD]}"
    local pre_arg="${COMP_WORDS[COMP_CWORD-1]}"
    local pre_pre_arg="${COMP_WORDS[COMP_CWORD-2]}"
    local comp_list _result old_IFS
    case "${#COMP_WORDS[@]}" in
        2) _comp_2 ;;
        3) _comp_3 ;;
        4) _comp_4 ;;
    esac
    return 0
}



complete -F _radio_completion radio

#  LocalWords:  musicvideo pre COMPREPLY
