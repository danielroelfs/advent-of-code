library(tidyverse)


input <- read_table("./2021/day_03/input_day03.txt", col_names = "full_binary")

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
