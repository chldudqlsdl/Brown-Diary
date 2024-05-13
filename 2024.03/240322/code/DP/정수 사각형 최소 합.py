import sys
n = int(sys.stdin.readline())

grid = [list(map(int, sys.stdin.readline().split())) for _ in range(n)]

sum_list = [([0]*n) for _ in range(n)]


def initialize():
    sum_list[0][n-1] = grid[0][n-1]

    for i in range(1, n):
        sum_list[0][n-1-i] = grid[0][n-1-i] + sum_list[0][n-i]
        sum_list[i][n-1] = grid[i][n-1] + sum_list[i-1][n-1]


initialize()
for i in range(1, n):
    for j in range(1, n):
        sum_list[i][n-1-j] = min(sum_list[i-1][n-1-j], sum_list[i][n-j]) + grid[i][n-1-j]

print(sum_list[n-1][0])