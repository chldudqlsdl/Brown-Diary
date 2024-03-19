n = input()

count = 0
six_nine = 0

num_list = [0,0,0,0,0,0,0,0,0,0]

for i in n:
    num_list[int(i)] += 1

if num_list[6] == max(num_list) or num_list[9] == max(num_list):
    if (num_list[6] + num_list[9]) % 2:
        six_nine = int((num_list[6] + num_list[9])/2) + 1
    else:
        six_nine = int((num_list[6] + num_list[9])/2)
    num_list[6] = 0
    num_list[9] = 0
    if six_nine >= max(num_list):
        count = six_nine
    else:
        count = max(num_list)
    
else: count = max(num_list)

print(count)

(num_list[6] + num_list[9]) % 2