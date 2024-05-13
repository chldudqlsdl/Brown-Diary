import sys

n = int(sys.stdin.readline())
A, B = map(int, sys.stdin.readline().split())
m = int(sys.stdin.readline())

visited = [False for _ in range(n + 1)]
graph = [[] for _ in range(n + 1)]

for _ in range(m):
    x, y = map(int, sys.stdin.readline().split())
    graph[x].append(y)
    graph[y].append(x)

answer = -1
flag = 0


def dfs(x, num):
    global answer, flag
    visited[x] = True
    num += 1

    if x == B:
        answer = num - 1
        flag = 1

    for i in graph[x]:
        if not visited[i] and not flag:
            dfs(i, num)
dfs(A, 0)
print(answer)

