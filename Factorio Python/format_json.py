import json
filename = 'temp.json'
with open(filename, 'r+') as f:
    dict = json.load(f)

with open(filename, 'w') as f:
    json.dump(dict, f, indent=2)
