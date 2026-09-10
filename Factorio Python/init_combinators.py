import json
filename = 'json_combinators.json'
with open(filename, 'r+') as f:
    dict = json.load(f)

list = [1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0]*128
b = []
for i in range(256):
    b.extend([int(p) for p in format(i, '08b')])
#list = [1 for i in range(2048)]

for (n,i) in enumerate(b):
    dict["blueprint"]["entities"][n]["control_behavior"]["is_on"] = "true" if i==1 else "false"
    dict["blueprint"]["entities"][n]["position"]["x"] = n%8 + (n//256)*8
    dict["blueprint"]["entities"][n]["position"]["y"] = -((n%256)//8)*3

with open(filename, 'w') as f:
    json.dump(dict, f, indent=2)
