import sys
from collections import deque

n, m = map(int, sys.stdin.readline().split())
graph = [list(map(int, sys.stdin.readline().split())) for _ in range(n)]
visited = [([False] * m) for _ in range(n)]


def in_range(x, y):
    return 0 <= x < n and 0 <= y < m


def can_go(x, y):
    return in_range(x, y) and graph[x][y] and not visited[x][y]


dxs, dys = [0, 0, 1, -1], [1, -1, 0, 0]


q = deque()

max_size = 0
size_count = 0
temp_size = 0


def bfs():
    while q:
        global temp_size
        x, y = q.popleft()
        temp_size += 1
        for dx, dy in zip(dxs, dys):
            nx = x + dx
            ny = y + dy
            if can_go(nx, ny):
                visited[nx][ny] = True
                q.append((nx, ny))


for i in range(n):
    for j in range(m):
        if can_go(i, j):
            visited[i][j] = True
            q.append((i, j))
            bfs()
            if temp_size > 0:
                size_count += 1
                if max_size < temp_size:
                    max_size = temp_size
            temp_size = 0

print(size_count)
print(max_size)
