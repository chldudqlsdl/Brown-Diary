from collections import deque
import sys

n, m = map(int, sys.stdin.readline().split())

graph = [list(map(int, sys.stdin.readline().split())) for _ in range(n)]

visited = [([False] * m) for _ in range(n)]

dxs = [0, 0, 1, -1]
dys = [1, -1, 0, 0]


def in_range(x, y):
    return 0 <= x < n and 0 <= y < m


def can_go(x, y):
    return in_range(x, y) and graph[x][y] and not visited[x][y]


q = deque()


def bfs():
    while q:
        x, y = q.popleft()
        for dx, dy in zip(dxs, dys):
            nx = x + dx
            ny = y + dy
            if can_go(nx, ny):
                q.append((nx, ny))
                visited[nx][ny] = True

q.append((0,0))
visited[0][0] = True

bfs()

answer = 1 if visited[n-1][m-1] else 0
print(answer)