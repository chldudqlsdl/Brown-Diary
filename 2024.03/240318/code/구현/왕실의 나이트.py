first_position = input()

sero_number = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']

garo = int(first_position[1])
sero = sero_number.index(first_position[0]) + 1

steps = [(1, 2), (1, -2),(-1, 2), (-1, -2), (2, 1), (2, -1), (-2, 1), (-2, -1) ]

count = 0

for i in steps:
    n_garo = garo + i[0]
    n_sero = garo + i[1]

    if n_garo > 0 and n_garo < 9 and n_sero > 0 and n_sero < 9:
        count += 1

print(count)




