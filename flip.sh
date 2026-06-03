#!/usr/bin/env bash

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

# copy and print the result
printf '%s' "$result" | pbcopy
printf '%s\n' "$result"
