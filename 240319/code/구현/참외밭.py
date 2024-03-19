n = input().split()

numbers = [
    list(map(int, input().split()))
    for _ in range(6)
]

check = [0, 0, 0, 0]

for i in range(6):
    check[numbers[i][0] - 1] += 1

max_1 = check.index(1)
max_2 = check.index(1, max_1, 4)

print(max_1)
print(max_2)
