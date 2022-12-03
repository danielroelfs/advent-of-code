library(tidyverse)

input <- read_table(here::here("2022", "day_02", "input_day02.txt"), 
                    col_names = c("x", "y"))

input |> 
  rename(opp = x,
         me = y) |> 
  mutate(opp_base_score = case_when(opp == "A" ~ 1,
                                    opp == "B" ~ 2,
                                    opp == "C" ~ 3),
         me_base_score = case_when(me == "X" ~ 1,
                                   me == "Y" ~ 2,
                                   me == "Z" ~ 3),
         score_diff = me_base_score - opp_base_score,
         me_turn_score = case_when(score_diff == -1 | score_diff == 2 ~ 0,
                                   score_diff == 0 ~ 3,
                                   score_diff == 1 | score_diff == -2 ~ 6),
         me_game_score = me_base_score + me_turn_score) |> 
  summarise(total_score = sum(me_game_score)) |> 
  pull(total_score) |> 
  print()
