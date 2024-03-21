import sys
from collections import  deque

n, m = map(int, sys.stdin.readline().split())
graph = [list(map(int, sys.stdin.readline().split())) for _ in range(n)]
visited = [([False] * m) for _ in range(n)]


def in_range(x, y):
    return 0 <= x < n and 0 <= y < m


def can_go(x, y):
    return in_range(x, y) and graph[x][y] and not visited[x][y]


dxs, dys = [0, 0, 1, -1], [1, -1, 0, 0]

q = deque()

ans = -1


def bfs():
    global ans
    while q:
        x, y, num = q.popleft()
        for dx, dy in zip(dxs, dys):
            nx = x + dx
            ny = y + dy
            if can_go(nx, ny):
                visited[nx][ny] = True
                q.append((nx, ny, num + 1))
                if nx == n - 1 and ny == m - 1:
                    ans = num + 1


visited[0][0] = True
q.append((0, 0, 0))
bfs()
print(ans)

