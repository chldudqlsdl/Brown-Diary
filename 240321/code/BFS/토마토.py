import sys
from collections import deque


A, B = map(int, sys.stdin.readline().split())
n, m = B, A

graph = [list(map(int, sys.stdin.readline().split())) for _ in range(n)]

visited = [([False] * m) for _ in range(n)]

q = deque()

answer = 0

dxs, dys = [0, 0, 1, -1], [1, -1, 0, 0]

def in_range(x, y):
    return 0 <= x < n and 0 <= y < m


def can_go(x, y):
    return in_range(x, y) and not visited[x][y] and graph[x][y] == 0


def bfs():
    global  answer
    while q:
        x, y, num = q.popleft()
        if answer < num:
            answer = num
        for dx, dy in zip(dxs, dys):
            nx = x + dx
            ny = y + dy
            if can_go(nx, ny):
                visited[nx][ny] = True
                q.append((nx, ny, num+1))
                graph[nx][ny] = 1


# 익은 토마토 찾기
for i in range(n):
    for j in range(m):
        if graph[i][j] == 1:
            q.append((i, j, 0))
            visited[i][j] = True

bfs()
for i in range(n):
    for j in range(m):
        if graph[i][j] == 0:
            answer = -1

print(answer)




