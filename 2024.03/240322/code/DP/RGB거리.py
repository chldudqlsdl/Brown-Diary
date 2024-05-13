import sys
n = int(sys.stdin.readline())

grid = [list(map(int, sys.stdin.readline().split())) for _ in range(n)]

dp = [([0] * 3) for _ in range(n)]

for i in range(3):
    dp[0][i] = grid[0][i]

for i in range(1, n):
    for j in range(3):
        check_list = [0, 1, 2]
        check_list.remove(j)
        dp[i][j] = min(grid[i][j] + dp[i-1][check_list[0]], grid[i][j] + dp[i-1][check_list[1]])

print(min(dp[n-1]))
