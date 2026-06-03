#!/usr/bin/env bash

declare -i table_count
table_count=$(find ./tables -name "*.txt" | wc -l)
echo "$table_count"

n=$(($RANDOM % $table_count))
tables=(./tables/*)
echo "$n"

result="${tables[$n]}"
echo "$result"
cat $result | pbcopy
