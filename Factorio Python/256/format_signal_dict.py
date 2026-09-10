import json
# Test for working directory
import os
print(os.getcwd())

# Usual filenames
filename_in = 'signals_indexed_bp.json'
filename_out = 'signals_indexed_temp.json'

with open(filename_in, 'r+') as f:
    dict = json.load(f)

# Print number of signals
print(len(dict))

# Formating to wanted dict in list with count parameter
signals=[]
for n, i in enumerate(dict):
    signals.append({
    "index" : n+1,
    "type": i["type"],
    "name": i["name"],
    "quality": "normal",
    "comparator": "=",
    "count": 1
  })

# Writing to file
with open(filename_out, 'w') as f:
    json.dump(signals, f, indent=2)
