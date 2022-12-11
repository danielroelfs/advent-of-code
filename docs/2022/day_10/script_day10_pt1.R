library(tidyverse)

input <- read_table(here::here("2022", "day_10", "input_day10.txt"), 
                    col_names = c("operation", "argument"))

input |> 
  replace_na(list(argument = 0)) |> 
  mutate(steps = case_when(str_detect(operation, "add") ~ 2, 
                           str_detect(operation, "noop") ~ 1),
         step_num_start = tail(accumulate(steps, `+`, .init = 1), -1) - steps,
         x_reg = 1 + cumsum(argument),
         x_reg_prev = c(1, head(x_reg, -1))) |> 
  uncount(steps) |> 
  rowid_to_column(var = "step_num") |> 
  select(step_num, x_reg_prev) |>
  rename(x_reg = x_reg_prev) |> 
  filter(step_num %in% seq(20, n(), 40)) |> 
  summarise(total = sum(step_num * x_reg)) |> 
  pull(total) |> 
  print()
