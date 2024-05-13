import sys
n = int(sys.stdin.readline())

a = list(map(int, sys.stdin.readline().split()))

max_num = -1001

dp = [max_num for _ in range(n)]

dp[0] = a[0]

for i in range(1, n):
    if dp[i-1] < 0:
        dp[i] = a[i]
    else:
        dp[i] = dp[i-1] + a[i]

print(max(dp))
