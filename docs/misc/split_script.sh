#!/bin/bash

day=`printf %02d $1`
year=`date +"%Y"`

cat ./${year}/day_${day}/script_day${day}.R | \
    awk '/^#-- Libraries/,/^#-- Part 1/ { print }' | \
    sed '/^#/d' | \
    sed '/./,$!d' | \
    cat -s > ./${year}/day_${day}/script_day${day}_pt1.R

cp ./${year}/day_${day}/script_day${day}_pt1.R ./${year}/day_${day}/script_day${day}_pt2.R

cat ./${year}/day_${day}/script_day${day}.R | \
    awk '/^#-- Part 1/,/^#-- Part 2/ { print }' | \
    sed '/^#/d' | \
    sed -e :a -e '/./,$!d;/^\n*$/{$d;N;};/\n$/ba' >> ./${year}/day_${day}/script_day${day}_pt1.R

cat ./${year}/day_${day}/script_day${day}.R | \
    awk '/^#-- Part 2/,/^EOF/ { print }' | \
    sed '/^#/d' | \
    sed -e :a -e '/./,$!d;/^\n*$/{$d;N;};/\n$/ba' >> ./${year}/day_${day}/script_day${day}_pt2.R