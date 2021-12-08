### ADVENT OF CODE - DAY 3 ########################

#-- Libraries -------------------------

library(tidyverse)

#-- Load data ------------------------

#input <- read_table("./2021/day_03/test_input_day03.txt", col_names = "full_binary")
input <- read_table("./2021/day_03/input_day03.txt", col_names = "full_binary")

#-- Part 1 ------------------------

# What is the power consumption of the submarine?

n_bits <- input %>% 
  pull(full_binary) %>% 
  nchar() %>% 
  unique()

input_conv <- input %>% 
  separate(full_binary, into = str_glue("bit{seq(0,n_bits)}"), sep = "") %>% 
  select(-bit0) %>% 
  pivot_longer(starts_with("bit"), names_to = "bit_no") %>%
  mutate(value = as.numeric(value),
         bit_no = parse_number(bit_no)) %>% 
  group_by(bit_no) %>% 
  count(value)

gamma_rate <- input_conv %>% 
  slice_max(n) %>% 
  pull(value) %>% 
  str_c(collapse = "")

gamma_rate_dec <- strtoi(gamma_rate, base = 2)

epsilon_rate <- input_conv %>% 
  slice_min(n) %>% 
  pull(value) %>% 
  str_c(collapse = "")

epsilon_rate_dec <- strtoi(epsilon_rate, base = 2)

print(gamma_rate_dec * epsilon_rate_dec)

#-- Part 2 ------------------------

# What is the life support rating of the submarine?

input_conv_wide <- input %>% 
  separate(full_binary, into = str_glue("bit{seq(0,n_bits)}"), sep = "") %>% 
  select(-bit0) %>% 
  mutate(across(everything(), ~ as.numeric(.x)))

apply_rule <- function(df, iteration, minmax = "max") {
  
  most_common <- df %>% 
    select(all_of(iteration)) %>% 
    group_by(across(everything())) %>% 
    count() %>% 
    ungroup()
  
  if (minmax == "max") {
    most_common <- most_common %>% 
      slice_max(n) %>% 
      pull(1)
  } else {
    most_common <- most_common %>% 
      slice_min(n) %>% 
      pull(1)
  }
  
  if (length(most_common) > 1) {
    most_common <- ifelse(minmax == "max", 1, 0)
  }
  
  df <- df %>% 
    filter(across(iteration, ~ .x == most_common))
  
  return(df)
  
}

oxygen_rating <- reduce(seq(n_bits), ~ apply_rule(.x, .y, minmax = "max"), 
                        .init = input_conv_wide) %>% 
  as.numeric() %>% 
  str_c(collapse = "") %>% 
  strtoi(base = 2)

co2_rating <- reduce(seq(n_bits), ~ apply_rule(.x, .y, minmax = "min"), 
                     .init = input_conv_wide) %>% 
  as.numeric() %>% 
  str_c(collapse = "") %>% 
  strtoi(base = 2)

print(oxygen_rating * co2_rating)

