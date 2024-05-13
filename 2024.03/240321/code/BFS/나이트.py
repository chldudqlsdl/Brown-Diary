import sys
from collections import deque

n = int(sys.stdin.readline())
r1, c1, r2, c2 = map(int, sys.stdin.readline().split())

visited = [([False] * n) for _ in range(n)]


def in_range(x, y):
    return 0 <= x < n and 0 <= y < n


def can_go(x, y):
    return in_range(x, y) and not visited[x][y]


dxs = [-1, -2, -2, -1, 1, 2, 2, 1]
dys = [-2, -1, 1, 2, -2, -1, 1, 2]

q = deque()

answer = -1


def bfs():
    global answer
    while q:
        x, y, num = q.popleft()
        if x == r2-1 and y == c2-1:
            answer = num
        for dx, dy in zip(dxs, dys):
            nx = x + dx
            ny = y + dy
            if can_go(nx, ny):
                visited[nx][ny] = True
                q.append((nx, ny, num+1))


visited[r1-1][c1-1] = True
q.append((r1-1, c1-1, 0))
bfs()

print(answer)