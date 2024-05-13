import sys
from collections import deque

n = int(sys.stdin.readline())
graph = [list(input()) for _ in range(n)]
visited = [([False] * n) for _ in range(n)]


dxs, dys = [0, 0, 1, -1], [1, -1, 0, 0]


def in_range(x, y):
    return 0 <= x < n and 0 <= y < n


def can_go(x, y):
    return in_range(x, y) and not visited[x][y]


q = deque()

answer = []
temp_count = 0


def bfs():
    while q:
        x, y, num = q.popleft()
        for dx, dy in zip(dxs, dys):
            nx = x + dx
            ny = y + dy
            if can_go(nx, ny) and graph[x][y] == graph[nx][ny]:
                    visited[nx][ny] = True
                    q.append((nx, ny, num+1))


for i in range(n):
    for j in range(n):
        if can_go(i, j):
            temp_count += 1
            visited[i][j] = True
            q.append((i, j, 0))
            bfs()
answer.append(temp_count)
temp_count = 0

for i in range(n):
    for j in range(n):
        if graph[i][j] == 'R':
            graph[i][j] = 'G'
visited = [([False] * n) for _ in range(n)]

for i in range(n):
    for j in range(n):
        if can_go(i, j):
            temp_count += 1
            visited[i][j] = True
            q.append((i, j, 0))
            bfs()
answer.append(temp_count)


print(answer[0], answer[1])