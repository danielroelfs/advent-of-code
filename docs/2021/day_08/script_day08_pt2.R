library(tidyverse)

input <- read_delim(here::here("2021","day_08","input_day08.txt"), delim = "|", 
                    col_names = FALSE)

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
