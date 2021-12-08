### ADVENT OF CODE - DAY 8 ########################

#-- Libraries -------------------------

library(tidyverse)

#-- Load data ------------------------

#input <- read_delim(here::here("2021","day_08","test_input_day08.txt"), delim = "|", col_names = FALSE)
input <- read_delim(here::here("2021","day_08","input_day08.txt"), delim = "|", 
                    col_names = FALSE)

#-- Part 1 ------------------------

# In the output values, how many times do digits 1, 4, 7, or 8 appear?

numbers <- c("1" = 2, "4" = 4, "7" = 3, "8" = 7)

input %>% 
  select(output = X2) %>% 
  mutate(output = str_trim(output)) %>% 
  separate(output, into = str_glue("digit{seq(4)}")) %>% 
  mutate(across(everything(), ~ nchar(.x))) %>% 
  pivot_longer(cols = everything(), names_to = "digit", 
               values_to = "n_segments") %>% 
  filter(n_segments %in% numbers) %>% 
  nrow() %>% 
  print()

#-- Part 2 ------------------------

# For each entry, determine all of the wire/segment connections and decode the four-digit output values. 
# What do you get if you add up all of the output values?

split_segments <- function(x) {
  x %>% 
    str_split(., " ") %>%
    map(., ~ str_split(.x, pattern = "")) %>%
    map(., ~ map(.x, ~ sort(.x)))
}

data <- input %>%
  rename(input = X1,
         output = X2) %>% 
  mutate(across(everything(), ~ str_trim(.x))) %>% 
  mutate(across(c("input", "output"), split_segments))

solver <- function(input, output) {
  
  setdiff_length <- function(x, y) {
    lengths(map(x, ~setdiff(x[[which(y)]], .x)))
  }
  
  x1 <- lengths(input) == 2
  x4 <- lengths(input) == 4
  x7 <- lengths(input) == 3
  x8 <- lengths(input) == 7
  x6 <- lengths(input) == 6 & setdiff_length(input, x1) == 1
  x0 <- lengths(input) == 6 & setdiff_length(input, x4) == 1 & !x6
  x9 <- lengths(input) == 6 & !x6 & !x0
  x5 <- lengths(input) == 5 & setdiff_length(input, x6) == 1
  x3 <- lengths(input) == 5 & setdiff_length(input, x9) == 1 & !x5
  x2 <- lengths(input) == 5 & !x5 & !x3
  
  cont <- list(x0, x1, x2, x3, x4, x5, x6, x7, x8, x9) %>%
    map(~ input[[which(.x)]]) %>%
    map(sort)
  
  output %>%
    match(cont) %>%
    magrittr::subtract(., 1) %>%
    str_c(collapse = "") %>%
    as.numeric()
}

data %>%
  mutate(res = map2_dbl(input, output, ~ solver(.x, .y))) %>%
  summarise(sum = sum(res)) %>% 
  pull(sum) %>% 
  print()
