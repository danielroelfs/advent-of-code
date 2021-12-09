library(tidyverse)

input <- read_table("./2021/day_03/input_day03.txt", col_names = "full_binary")

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
