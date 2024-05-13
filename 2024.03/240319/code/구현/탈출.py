n, m = map(int, input().split())
x, y, dir = map(int, input().split())
grid = [
    list(map(int, input().split()))
    for _ in range(m)
]

# 북동남서
dx = [-1, 0, 1, 0]
dy = [0, 1, 0, -1]

count = 0
check = False

def in_range(x, y):
    return x >= 0 and x < n and y >= 0  and y < m

while True:

    check = False
    
    # 현재 칸 비면 청소
    if grid[x][y] == 0:
            count += 1
    # 빈칸체크
    # 주위에 빈칸이 있는 경우
    for _ in range(4):
        dir = (dir + 3) % 4
        if in_range(x + dx[dir], y + dy[dir]) and grid[x + dx[dir]][y + dy[dir]] == 0:
                x += dx[dir]
                y += dy[dir]
                check = True
                break
    if check:
          if in_range(x + dx[(dir + 2) % 4], y + dy[(dir + 2) % 4]):
                break
          else:
                x = x + dx[(dir + 2) % 4]
                y = y + dy[(dir + 2) % 4]
print(count)
                           




            
            

