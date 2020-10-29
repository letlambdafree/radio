#/usr/bin/env bash
#
# completion for radio
#

# COMP_WORDS is an array containing all individual words in the current command line.
# COMP_CWORD is an index of the word containing the current cursor position.
# COMPREPLY is an array variable from which Bash reads the possible completions.
# And the compgen command returns the array of elements from --help, --verbose and --version matching the current word "${cur}":


g_arg0="$0"
SCRIPT_PATH=$(realpath "$g_arg0") # test
SCRIPT_DIR="${SCRIPT_PATH%/*}"
ARR_YOUTUBE_SEARCH="$SCRIPT_DIR"/arr_youtube_search
source "$ARR_YOUTUBE_SEARCH"

_radio_completions() {
    local COMPREPLY=()
    local prev_arg="${COMP_WORDS[COMP_CWORD-1]}"
    local curr_arg="${COMP_WORDS[COMP_CWORD]}"

    case ${#COMP_WORDS[@]} in
        3)
            if [[ $curr_arg == -c ]]; then
            for item in "${!arr_search[@]}"; do
                COMPREPLY+=( "$item" )
            done
            fi
            return 0
            ;;
        4)
            if [[ $prev_arg == -c ]]; then
                for item in "${!arr_search[@]}"; do
                COMPREPLY+=( "$item" )
            done
            fi
            return 0
            ;;
        *)
            echo ${#COMP_WORDS[@]}
            echo "${COMP_WORDS[COMP_CWORD]}"
            COMPREPLY=()
            return 1
            ;;
    esac
    return 0
}

complete -F _radio_completions radio
