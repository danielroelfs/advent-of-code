import os

input = open(os.path.join("2024", "day_02", "input_day02.txt")).read().split("\n")
input = [[int(level) for level in report.split(" ")] for report in input]

def check_if_save(report):
    increasing = [report[i + 1] - report[i] for i in range(len(report) - 1)]
    if set(increasing) <= {1, 2, 3} or set(increasing) <= {-1, -2, -3}:
        return True
    else:
        return False

def part2(input):
    n_safe = sum(
        [
            any(
                [
                    check_if_save(report[:i] + report[i + 1 :])
                    for i in range(len(report))
                ]
            )
            for report in input
        ]
    )
    return n_safe


print(part2(input))
