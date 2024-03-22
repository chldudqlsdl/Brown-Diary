import sys

n = int(sys.stdin.readline())

a = list(map(int, sys.stdin.readline().split()))

dp = [1 for _ in range(n)]

for i in range(1, n):
    for j in range(0, i):
        if a[j] < a[i]:
            if dp[i] <= dp[j]:
                dp[i] = dp[j] + 1

print(max(dp))

