### ADVENT OF CODE - DAY 5 ########################

#-- Libraries -------------------------

library(tidyverse)

#-- Load data ------------------------

crates <- read_fwf(here::here("2022", "day_05", "input_day05.txt"), 
                   col_positions = fwf_widths(widths = NA)) |> 
  janitor::clean_names() |> 
  filter(str_detect(x1, "\\[")) |> 
  separate(x1,
           into = str_glue("stack_{seq(9)}"), 
           sep = c(seq(from = 4, to = 37, by = 4))) |> 
  mutate(across(everything(), ~ str_extract(.x, "[A-Z]"))) |> 
  as.list() |> 
  map(~ .x[grepl("[A-Z]", .x)])

steps <- read_delim(here::here("2022", "day_05", "input_day05.txt"), skip = 10,
                    col_names = c("action", "index", "f", "from", "t", "to")) |> 
  select(index, from, to) |> 
  mutate(across(c(from, to), ~ str_c("stack_", .x)))

#-- Part 1 ------------------------

# After the rearrangement procedure completes, what crate ends up on top of each stack?

rearrange_crates <- function(x, steps){
  from <- steps$from
  to <- steps$to
  n <- steps$index
  
  for(i in seq(n)) {  
    x[[to]] <- c(x[[from]][1], x[[to]])
    x[[from]]<- tail(x[[from]], length(x[[from]])-1)
  }
  return(x)
}

reduce(rlist::list.parse(steps), rearrange_crates, .init = crates) |> 
  map_chr(~ .x[1]) |> 
  paste(collapse = "") |> 
  print()

#-- Part 2 ------------------------

# After the rearrangement procedure completes, what crate ends up on top of each stack?

rearrange_crates_pt2 <- function(x, steps){
  from <- steps$from
  to <- steps$to
  n <- steps$index
  
  x[[to]] <- c(x[[from]][seq(n)], x[[to]])
  x[[from]]<- tail(x[[from]], length(x[[from]])-n)
  return(x)
}

reduce(rlist::list.parse(steps), rearrange_crates_pt2, .init = crates) |> 
  map_chr(~ .x[1]) |> 
  paste(collapse = "") |> 
  print()
