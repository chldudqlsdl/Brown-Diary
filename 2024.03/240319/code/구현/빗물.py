h, w = map(int, input().split())
block_map = list(map(int, input().split()))

count = 0

location = 0
last_point = len(block_map) - 1

while location < last_point:
    if block_map[location] <= block_map[location+1]:
        location += 1
        continue
    else:
        for i in range(last_point - location):
            if block_map[location] <= block_map[location + i + 1]:
                for j in range(i):
                    count += block_map[location] - block_map[location + j + 1]
                location += i + 1
                break

print(count)


# h, w = map(int, input().split())
# world = list(map(int, input().split()))

# ans = 0
# for i in range(1, w - 1):
#     left_max = max(world[:i])
#     right_max = max(world[i+1:])

#     compare = min(left_max, right_max)

#     if world[i] < compare:
#         ans += compare - world[i]

# print(ans)