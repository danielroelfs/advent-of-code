#!/bin/bash

if [ "$#" -lt 1 ]; then
    echo -e "\nYou forgot to provide the day number!\n"
    exit
fi

if [ "$#" -lt 2 ]; then
    echo -e "\nI'm assuming you wrote this in Python\n"
    suffix=`echo py`
else
    suffix=${2}
fi

day=`printf %02d $1`
year=`date +"%Y"`

cat ./${year}/day_${day}/script_day${day}.${suffix} | \
    awk '/^# -- Libraries/,/^# -- Part 1/ { print }' | \
    sed '/^#/d' | \
    sed '/./,$!d' | \
    cat -s > ./${year}/day_${day}/script_day${day}_pt1.${suffix}

cp ./${year}/day_${day}/script_day${day}_pt1.${suffix} ./${year}/day_${day}/script_day${day}_pt2.${suffix}

cat ./${year}/day_${day}/script_day${day}.${suffix} | \
    awk '/^# -- Part 1/,/^# -- Part 2/ { print }' | \
    sed '/^#/d' | \
    sed -e :a -e '/./,$!d;/^\n*$/{$d;N;};/\n$/ba' >> ./${year}/day_${day}/script_day${day}_pt1.${suffix}

cat ./${year}/day_${day}/script_day${day}.${suffix} | \
    awk '/^# -- Part 2/,/^EOF/ { print }' | \
    sed '/^#/d' | \
    sed -e :a -e '/./,$!d;/^\n*$/{$d;N;};/\n$/ba' >> ./${year}/day_${day}/script_day${day}_pt2.${suffix}