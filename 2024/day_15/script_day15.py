### ADVENT OF CODE - DAY 15 ########################

# -- Libraries -------------------------

import os

# -- Load data ------------------------

input = open(os.path.join("2024", "day_15", "input_day15.txt")).read().split("\n\n")

# -- Part 1 ------------------------

# Predict the motion of the robot and boxes in the warehouse.
# After the robot is finished moving, what is the sum of all boxes' GPS coordinates?


def move_coordinates(coord1, coord2):
    new_coords = tuple(i + j for i, j in zip(coord1, coord2))
    return new_coords


def part1(input):
    grid = input[0].splitlines()
    moves = input[1].replace("\n", "")

    boxes = {
        (i, j)
        for i, line in enumerate(grid)
        for j, char in enumerate(line)
        if char == "O"
    }
    walls = {
        (i, j)
        for i, line in enumerate(grid)
        for j, char in enumerate(line)
        if char == "#"
    }
    robot = [
        (i, j)
        for i, line in enumerate(grid)
        for j, char in enumerate(line)
        if char == "@"
    ]
    assert len(robot) == 1
    robot = robot[0]

    move_dict = {"<": (0, -1), "^": (-1, 0), "v": (1, 0), ">": (0, 1)}

    for move in moves:
        direction = move_dict[move]
        target1 = move_coordinates(robot, direction)
        if target1 not in walls and target1 not in boxes:
            robot = target1
        else:
            target2 = target1
            while target2 in boxes:
                target2 = move_coordinates(target2, direction)
            if target2 in walls:
                continue
            else:
                robot = target1
                boxes.remove(target1)
                boxes.add(target2)

    answer = sum(100 * i + j for i, j in boxes)

    return answer


print(part1(input))
