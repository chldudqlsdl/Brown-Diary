n = int(input())
steps = []

x = 0
y = 0

direction_list = "EWSN"
dx = [1, -1, 0, 0]
dy = [0, 0, -1, 1]

for i in range(n):
    dir, count = tuple(input().split())
    x += dx[direction_list.index(dir)] * int(count)
    y += dx[direction_list.index(dir)] * int(count)

print(x, y)