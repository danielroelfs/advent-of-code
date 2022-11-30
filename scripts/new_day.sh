#!/bin/bash

day=`printf %02d $1`
year=`date +"%Y"`

mkdir ./${year}/day_${day}
touch ./${year}/day_${day}/input_day${day}.txt
touch ./${year}/day_${day}/test_input_day${day}.txt

echo """### ADVENT OF CODE - DAY ${1} ########################

#-- Libraries -------------------------

library(tidyverse)

#-- Load data ------------------------

input <- read_csv(here::here(\"${year}\",\"day_${day}\",\"test_input_day${day}.txt\"), col_names = FALSE)

#-- Part 1 ------------------------

# 


#-- Part 2 ------------------------

# 

""" > ./${year}/day_${day}/script_day${day}.R

echo """# Advent of Code - Day ${1}

[link to the challenge](https://adventofcode.com/2021/day/${1})

""" > ./${year}/day_${day}/README.md

