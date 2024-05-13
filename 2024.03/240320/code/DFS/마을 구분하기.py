n = int(input())

grid = [
    list(map(int, input().split()))
    for _ in range(n)
]

visited = [
    [False for _ in range(n)]
    for _ in range(n)
]

def in_range(x, y):
    return x >= 0 and x < n and y >= 0 and y < n

def can_go(x, y):
    if not in_range(x, y):
        return False
    
    if grid[x][y] == 1 and visited[x][y] == 0:
        return True
    
    return False

people_in_towns = []
people_in_one_town = 0

dxs = [0, 0, 1, -1]
dys = [1, -1, 0, 0]

def dfs(x, y):
    global people_in_one_town

    for dx, dy in zip(dxs, dys):
        nx = x + dx
        ny = y + dy
        if can_go(nx, ny):
            people_in_one_town += 1
            visited[nx][ny] = True
            dfs(nx, ny)

for i in range(n):
    for j in range(n):
        if can_go(i, j):
            people_in_one_town = 1
            visited[i][j] = True
            dfs(i, j)
            people_in_towns.append(people_in_one_town)

people_in_towns.sort()

print(len(people_in_towns))
for i in range(len(people_in_towns)):
    print(people_in_towns[i])