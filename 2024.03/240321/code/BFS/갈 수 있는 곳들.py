import sys
from collections import deque

n, k = map(int, sys.stdin.readline().split())
graph = [list(map(int, sys.stdin.readline().split())) for _ in range(n)]
visited = [([False] * n) for _ in range(n)]


q = deque()


def in_range(x, y):
    return 0 <= x < n and 0 <= y < n


def can_go(x, y):
    return in_range(x, y) and not graph[x][y] and not visited[x][y]


dxs, dys = [0, 0, 1, -1], [1, -1, 0, 0]


def bfs():
    while q:
        x, y = q.popleft()

        for dx, dy in zip(dxs, dys):
            nx = x + dx
            ny = y + dy
            if can_go(nx, ny):
                visited[nx][ny] = True
                q.append((nx, ny))


for _ in range(k):
    x, y = map(int, sys.stdin.readline().split())
    visited[x-1][y-1] = True
    q.append((x-1, y-1))

bfs()

answer = sum([
    1
    for i in range(n)
    for j in range(n)
    if visited[i][j]
    ]
)

print(answer)