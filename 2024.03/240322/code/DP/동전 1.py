import sys

n, k = map(int, sys.stdin.readline().split())

coins = []

dp = [0 for _ in range(k+1)]
dp[0] = 1

for _ in range(n):
    coins.append(int(sys.stdin.readline()))

for i in range(1, k+1):
    for j in coins:
        if i >= j:
            dp[i] += dp[i-j]

print(dp)