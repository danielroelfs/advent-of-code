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
  mutate(step_num = seq(1, n())) |>
  select(step_num, x_reg_prev) |>
  rename(x_reg = x_reg_prev) |> 
  mutate(x_pos = (step_num - 1) %% 40,
         pixel_on = abs(x_pos - x_reg) < 2,
         pixel = ifelse(pixel_on, "#", NA),
         row_num = cumsum(x_pos == 0)) |> 
  group_by(row_num) |> 
  mutate(x = row_number()) |> 
  filter(pixel_on) |> 
  ggplot(aes(x = x, y = row_num)) +
  geom_tile(fill = "#f2f2f2") +
  geom_text(label = "#", color = "#b3b3b3", size = 4) +
  scale_y_reverse() +
  coord_equal() + 
  theme_void() + 
  theme(plot.margin = margin(rep(10,4), unit = "mm"),
        plot.background = element_rect(fill = "#0f0f23"))

ggsave(here::here("2022", "day_10", "plot_day10_pt2.png"), last_plot(), 
       height = 3, width = 8, dpi = 300)
