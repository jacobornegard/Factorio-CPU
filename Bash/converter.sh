#!/bin/bash

# The Factorio blueprint string uses a leading zero as a version byte which must be removed/added manually (as per the official Factorio Wiki) 

# Definig filenames
# Has to use absolute path as this script is run from Windows directory with /mnt/c/... as relatiev path
json_in="/home/jacob/factorio/json_in.txt"
json_out="/home/jacob/factorio/json_out.txt"
string_in="/home/jacob/factorio/string_in.txt"
string_out="/home/jacob/factorio/string_out.txt"
input_path="/mnt/c/Users/Jacob/AppData/Roaming/Factorio/script-output/bp_out.txt"
output_path="/home/jacob/factorio/string_in.txt"
bp_deposit_path="/mnt/c/Users/Jacob/AppData/Roaming/Factorio/mods/Testing_0.1.0/bp_in.lua"

printf "From $0: \nI'm executing...\n"

# printf "\nContent of input: "
# cat $InputPath

cp "$input_path" "$output_path"
printf "Content copyed!\n"

# cat $OutpoutPath
# printf "Content of string_in: "

# Function outputting Factorio BP string from raw JSON by compressing and converting to base64
encode() {
    printf "0%s" "$(zlib-flate -compress < "$json_in" | base64 -w 0)" > "$string_out"
    req_bp_string="return '$(cat "$string_out")'"
    printf "%s" "$req_bp_string" > "$bp_deposit_path"

    #printf "content of bp_in.lua"
    #cat $BpDepositPath
    
    printf "Encoded the input from $json_in to $string_out\n"

}

# Function outputting raw JSON from Factorio BP string by base64 decoding and uncompressing
decode() {
    cut -c2- < "$string_in" | base64 -d | zlib-flate -uncompress > "$json_out"
    printf "Decoded the input from $string_in to $json_out\n"
}

# Switch case to determine function called by parameter given at execution
case $1 in 
    "encode")
        encode
        ;;
    "decode")
        decode
        ;;
    *)
        printf "Needs argument: {encode|decode}\n"
        exit 1
        ;;
esac

printf "Commands executed!\n"