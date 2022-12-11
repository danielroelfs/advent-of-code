from collections import defaultdict
from itertools import accumulate

lines = open('./2022/day_07/input_day07.txt').read().splitlines()

dirs = defaultdict(int)

for line in lines:
  match line.split():
    case "$", "cd", "/":
      path = ["/"]
    case "$", "cd", "..":
      path.pop()
    case "$", "cd", dir:
      path.append(dir + "/")
    case "$" | "dir", *_:
      continue
    case size, _:
      for p in accumulate(path):
        dirs[p] += int(size)

total_sizes = sum(size for size in dirs.values() if size <= 1e5)
print(total_sizes)
