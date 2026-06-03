#!/usr/bin/env bash

# set path
cd "$(dirname "$0")"

# declare tables
declare -i table_count
table_count=$(find ./tables -name "*.txt" | wc -l)

# select random table and get its contents
n=$(($RANDOM % $table_count))
tables=(./tables/*)
result="$(cat ${tables[$n]})"

# trimming
result="${result#"${result%%[![:space:]]*}"}"
result="${result%"${result##*[![:space:]]}"}"
result=${result//$'\n'/}
result=${result//$'\r'/}

# copy to clipboard based on platform
copy_to_clipboard() {
    if command -v pbcopy &>/dev/null; then
        printf '%s' "$1" | pbcopy
    elif command -v clip.exe &>/dev/null; then
        # Windows (WSL or Git Bash)
        printf '%s' "$1" | clip.exe
    elif [ -n "$WAYLAND_DISPLAY" ] && command -v wl-copy &>/dev/null; then
        printf '%s' "$1" | wl-copy
    elif command -v xclip &>/dev/null; then
        printf '%s' "$1" | xclip -selection clipboard
    elif command -v xsel &>/dev/null; then
        printf '%s' "$1" | xsel --clipboard --input
    else
        printf 'Warning: no clipboard tool found (install xclip, xsel, or wl-clipboard)\n' >&2
    fi
}

copy_to_clipboard "$result"
printf '%s\n' "$result"
