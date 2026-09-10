import json

# File name to be used
file_combinator_bd = "combinator_template_out.json"
with open(file_combinator_bd, 'r') as f:
    bp_json = json.load(f)
f.close()

# List of Deciamal values for each of the 256 32 bit number
values = []

# Dictionary path in the blueprint string
signal_list = bp_json["blueprint"]["entities"][0]["control_behavior"]["sections"]["sections"][0]["filters"]

#Updating value attribute for each signal
for n, i in enumerate(signal_list):
    bp_json["blueprint"]["entities"][0]["control_behavior"]["sections"]["sections"][0]["filters"][n]["count"] = values[n]

# Updating the combinator bp output 
with open(file_combinator_bd, 'w') as f:
    json.dump(bp_json, f, indent=2)
