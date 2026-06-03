#!/usr/bin/env bash

declare -i table_count
table_count=$(ls -l tables | wc -l)
echo "$table_count"

n=$(($RANDOM % $table_count))
tables=(./tables/*)
echo "$n"

echo "${tables[$n]}"
