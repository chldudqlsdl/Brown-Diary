import sys

n = int(sys.stdin.readline())

num = [1, 2, 5]

dp = [0] * (n+1)
dp[0] = 1

for i in range(1, n+1):
    for j in range(3):
        if i >= num[j]:
            dp[i] = (dp[i] + dp[i - num[j]]) % 10007

print(dp[n])

