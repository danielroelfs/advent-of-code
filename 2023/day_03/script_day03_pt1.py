import os
import re

input = open(os.path.join("2023", "day_03", "input_day03.txt"), "r").read().splitlines()

def part1(input):
    padding = "." * len(input[0])
    padded = [padding] + input
    parts = []

    for i in range(len(input)):
        for match in re.finditer(r"\d+", input[i]):
            start, end = match.span()
            start, end = max(start - 1, 0), min(end + 1, len(input[i]))
            region = "".join([row[start:end] for row in padded[i : i + 3]])
            if re.search(r"[^.0-9]", region):
                parts.append(int(match.group(0)))

    return sum(parts)


print(part1(input))
