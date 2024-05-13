import sys

n = int(sys.stdin.readline())

memo = [[-1] for _ in range(46)]

memo[1] = 1
memo[2] = 1

for i in range(3, n+1):
    memo[i] = memo[i-1] + memo[i-2]

print(memo[n])