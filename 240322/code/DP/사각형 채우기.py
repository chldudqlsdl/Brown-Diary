import sys
n = int(sys.stdin.readline())

dp = [[-1] for _ in range(1001)]
dp[0] = 1
dp[1] = 1

for i in range(2, n+1):
    dp[i] = (dp[i-1] + dp[i-2]) % 10007

print(dp[n])