### ADVENT OF CODE - DAY 21 ########################

#-- Libraries -------------------------

library(tidyverse)

#-- Load data ------------------------

input <- read_delim(here::here("2021","day_21","input_day21.txt"), delim = ":", 
                    col_names = c("player","start_pos")) %>% 
  mutate(across(everything(), ~ parse_number(.x))) %>% 
  pull(start_pos)

#-- Part 1 ------------------------

# Play a practice game using the deterministic 100-sided die. The moment either player wins, 
# what do you get if you multiply the score of the losing player by the number of times the die was rolled during the game?

scores <- c(0, 0)
die_roll <- 0

die_value <- function(die_roll) {
  value <- if_else(die_roll %% 100 == 0, 100, die_roll %% 100)
  return(value)
}

place_value <- function(place_idx) {
  value <- if_else(place_idx %% 10 == 0, 10, place_idx %% 10)
  return(value)
}

roll_for_player <- function(player) {
  die_sum <- sum(die_value(die_roll + seq(3)))
  die_roll <<- die_roll + 3
  scores[player] <<- scores[player] + place_value(input[player] + die_sum)
  input[player] <<- place_value(input[player] + die_sum)
}

while (max(scores) < 1000) {
  roll_for_player(1)
  if (max(scores) < 1000) {
    roll_for_player(2)
  }
}

print(min(scores) * die_roll)

#-- Part 2 ------------------------

# Find the player that wins in more universes; in how many universes does that player win?


