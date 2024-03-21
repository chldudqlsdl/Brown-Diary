import sys
from collections import deque

n, k = map(int, sys.stdin.readline().split())

max_num = 100001

visited = [False for _ in range(max_num)]


def in_range(x):
    return 0 <= x < max_num


def can_go(x):
    return in_range(x) and not visited[x]


q = deque()
answer = -1
count = 0


def bfs():
    global answer, count
    while q and answer < 0:
        n, num = q.popleft()
        if n == k:
            answer = num
        for i in range(3):
            if i == 0:
                nn = n - 1
            elif i == 1:
                nn = n + 1
            else:
                nn = n*2
            if can_go(nn):
                visited[nn] = True
                q.append((nn, num+1))


visited[n] = True
q.append((n, 0))
bfs()

print(answer)