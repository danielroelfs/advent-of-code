import os
from shapely.geometry import Polygon

input = open(os.path.join("2025", "day_09", "input_day09.txt")).read().splitlines()

def part1(input):
    coords = [[int(y) for y in x.split(",")] for x in input]

    areas = []
    for xmin, ymin in coords:
        for xmax, ymax in coords:
            areas.append((abs(xmax - xmin) + 1) * (abs(ymax - ymin) + 1))

    largest_area = max(areas)

    return largest_area


print(part1(input))
