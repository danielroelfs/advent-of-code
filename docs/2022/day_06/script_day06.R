### ADVENT OF CODE - DAY 6 ########################

#-- Libraries -------------------------

#-- Load data ------------------------

#input <- readLines(here::here("2022", "day_06", "test_input_day06.txt"))
input <- readLines(here::here("2022", "day_06", "input_day06.txt"))

#-- Part 1 ------------------------

# How many characters need to be processed before the first start-of-packet marker is detected?

strsplit(input, split = "")[[1]] |> 
  slider::slide_lgl(~ length(.x) == 4 & length(.x) == length(unique(.x)), 
                    .before = 3) |> 
  (\(x) {which(x == TRUE)[1]})() |> 
  print()

#-- Part 2 ------------------------

# How many characters need to be processed before the first start-of-message marker is detected?

strsplit(input, split = "")[[1]] |> 
  slider::slide_lgl(~ length(.x) == 14 & length(.x) == length(unique(.x)), 
                    .before = 13) |> 
  (\(x) {which(x == TRUE)[1]})() |> 
  print()
