n, m = map(int, input().split())

grid = [
    list(map(int, input().split()))
    for _ in range(n)
]

visited = [
    [False for _ in range(m)]
    for _ in range(n)
]

dxs, dys = [1, 0], [0, 1]

def in_range(x, y):
    return x >= 0 and x < n and y >= 0 and y < m

def can_go(x, y):
    if in_range(x, y) and visited[x][y] == False and grid[x][y] == 1:
        return True
    else:
        return False
    
def dfs(x, y):
    for dx, dy in zip(dxs, dys):
        nx = x + dx
        ny = y + dy
        if can_go(nx, ny):
            visited[nx][ny] = True
            dfs(nx, ny)

visited[0][0] = True
dfs(0, 0)

if visited[n-1][m-1]:
    print(1)
else:
    print(0)