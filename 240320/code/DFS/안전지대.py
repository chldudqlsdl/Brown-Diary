n, m = map(int, input().split())

grid = [
    list(map(int, input().split()))
    for _ in range(n)
]

visited = [
    [False for _ in range(m)]
    for _ in range(n)
]

max_height = max(map(max, grid))

dxs = [0, 0, 1, -1]
dys = [1, -1, 0, 0]


def in_range(x, y):
    return 0 <= x < n and 0 <= y < m


def can_go(x, y, z):
    if not in_range(x, y):
        return False
    if visited[x][y]:
        return False
    if grid[x][y] > z:
        return True


def dfs(x, y, z):
    for dx, dy in zip(dxs, dys):
        nx = x + dx
        ny = y + dy

        if can_go(nx, ny, z):
            visited[nx][ny] = True
            dfs(nx, ny, z)


safe_areas_count = 0
max_safe_areas_count_per_height = -1
answer = 0

for i in range(1, max_height):
    safe_areas_count = 0
    visited = [
        [False for _ in range(m)]
        for _ in range(n)
    ]
    for j in range(n):
        for k in range(m):

            if can_go(j, k, i):
                visited[j][k] = True
                safe_areas_count += 1
                dfs(j, k, i)
    if max_safe_areas_count_per_height < safe_areas_count:
        max_safe_areas_count_per_height = safe_areas_count
        answer = i

print(answer, max_safe_areas_count_per_height)
