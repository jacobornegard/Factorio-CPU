import json

# File names
file_signals = "signals_indexed_bp.json"
file_combinator_bd_in = "combinator_template_empty.json"
file_combinator_bd_out = "combinator_template_out.json"

# Reading the signal list and empty combinator bp template
with open(file_signals, 'r') as fin:
    signal_list = json.load(fin)
with open(file_combinator_bd_in, 'r') as fin2:
    combinator_dict = json.load(fin2)

# Updating the filters list of the combinator
# Only 1 entity in bp => [0]
combinator_dict["blueprint"]["entities"][0]["control_behavior"]["sections"]["sections"][0]["filters"] = signal_list

# print(combinator_dict["blueprint"]["entities"][0]["control_behavior"]["sections"]["sections"][0]["filters"])

# Updating the combinator bp output 
with open(file_combinator_bd_out, 'w') as fout:
    json.dump(combinator_dict, fout, indent=2)