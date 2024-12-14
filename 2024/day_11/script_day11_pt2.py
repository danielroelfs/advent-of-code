import os
from functools import cache

input = open(os.path.join("2024", "day_11", "input_day11.txt")).read().split()

@cache
def calculate_state(n):
    if n == 0:
        return [1]

    string_num = str(n)
    if len(string_num) % 2 == 0:
        mid = len(string_num) // 2
        return [int(string_num[:mid]), int(string_num[mid:])]

    new_state = [n * 2024]
    return new_state

@cache
def stone_count(stone, blinks_left):
    if blinks_left == 0:
        return 1

    new_stone_state = calculate_state(stone)
    new_stone_count = sum(stone_count(num, blinks_left - 1) for num in new_stone_state)

    return new_stone_count

def part2():
    n_blinks = 75
    stones = list(int(stone) for stone in input)

    total_stones = 0
    for stone in stones:
        total_stones += stone_count(stone, n_blinks)

    return total_stones


print(part2())
