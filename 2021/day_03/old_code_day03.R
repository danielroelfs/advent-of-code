#-- Part 2 ------------------------

# What is the life support rating of the submarine?

input_conv <- input %>% 
  separate(full_binary, into = str_glue("bit{seq(0,n_bits)}"), sep = "") %>% 
  select(-bit0) %>% 
  mutate(across(everything(), ~ as.numeric(.x)))

input_it <- input_conv
for (i in seq(n_bits)) {
  
  most_common <- input_it %>% 
    select(all_of(i)) %>% 
    group_by(across(everything())) %>% 
    count() %>% 
    ungroup() %>% 
    slice_max(n) %>% 
    pull(1)
  
  if (length(most_common) > 1) {
    most_common <- 1
  }
  
  input_it <- input_it %>% 
    filter(across(i, ~ .x == most_common))
  
  if (nrow(input_it) == 1) {
    break
  }
  
}

oxygen_rating <- input_it %>% 
  as.numeric() %>% 
  str_c(collapse = "") %>% 
  strtoi(base = 2)


input_it <- input_conv
for (i in seq(n_bits)) {
  
  most_common <- input_it %>% 
    select(all_of(i)) %>% 
    group_by(across(everything())) %>% 
    count() %>% 
    ungroup() %>% 
    slice_min(n) %>% 
    pull(1)
  
  if (length(most_common) > 1) {
    most_common <- 0
  }
  
  input_it <- input_it %>% 
    filter(across(i, ~ .x == most_common))
  
  if (nrow(input_it) == 1) {
    break
  }
  
}

co2_rating <- input_it %>% 
  as.numeric() %>% 
  str_c(collapse = "") %>% 
  strtoi(base = 2)

oxygen_rating * co2_rating
