### ADVENT OF CODE - DAY 7 ########################

#-- Libraries -------------------------

from collections import defaultdict
from itertools import accumulate

#-- Load data ------------------------

#lines = open('./2022/day_07/test_input_day07.txt').read().splitlines()
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

#-- Part 1 ------------------------

# Find all of the directories with a total size of at most 100000. 
# What is the sum of the total sizes of those directories?

total_sizes = sum(size for size in dirs.values() if size <= 1e5)
print(total_sizes)

#-- Part 2 ------------------------

# Find the smallest directory that, if deleted, would free up enough space on the filesystem to run the update. 
# What is the total size of that directory?

dir_to_remove = min(size for size in dirs.values() if size >= dirs["/"] - 40e6)
print(dir_to_remove)

