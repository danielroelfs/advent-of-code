library(tidyverse)

input <- read_table(here::here("2022", "day_02", "input_day02.txt"), 
                    col_names = c("x", "y"))

input |> 
  rename(opp = x,
         outcome = y) |> 
  mutate(opp_base_score = case_when(opp == "A" ~ 1,
                                    opp == "B" ~ 2,
                                    opp == "C" ~ 3),
         me_turn_score = case_when(outcome == "X" ~ 0,
                                   outcome == "Y" ~ 3,
                                   outcome == "Z" ~ 6),
         me_base_score = case_when(me_turn_score == 3 ~ opp_base_score,
                                   me_turn_score == 0 & 
                                     opp_base_score > 1 ~ opp_base_score - 1,
                                   me_turn_score == 0 & opp_base_score == 1 ~ 3,
                                   me_turn_score == 6 & 
                                     opp_base_score < 3 ~ opp_base_score + 1,
                                   me_turn_score == 6 & opp_base_score == 3 ~ 1),
         me_game_score = me_turn_score + me_base_score) |> 
  summarise(total_score = sum(me_game_score)) |> 
  pull(total_score) |> 
  print()
