lines = open('./2022/day_08/input_day08.txt').read().splitlines()

trees = [[*map(int, line)] for line in lines]

n = 2 * (len(trees[0]) + len(trees) - 2)

for y in range(1, len(trees) - 1):
  for x in range(1, len(trees[0]) - 1):
    tree = trees[y][x]
    
    row = trees[y]
    col = [i[x] for i in trees]
    
    left = row[:x]
    right = row[x + 1 :]
    top = col[:y]
    bottom = col[y + 1 :]
    
    if tree > min(max(left), max(right), max(top), max(bottom)):
      n += 1

print(n)
      
