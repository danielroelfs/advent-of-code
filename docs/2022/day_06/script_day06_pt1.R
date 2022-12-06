input <- readLines(here::here("2022", "day_06", "input_day06.txt"))

strsplit(input, split = "")[[1]] |> 
  slider::slide_lgl(~ length(.x) == 4 & length(.x) == length(unique(.x)), 
                    .before = 3) |> 
  (\(x) {which(x == TRUE)[1]})() |> 
  print()
