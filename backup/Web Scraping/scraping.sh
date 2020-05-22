#!/bin/bash
rm -f tmp_file extractData.csv

# write headers to CSV file
echo "Title;Description" > extractData.csv

# exec the curl and save to tmp_file
curl "https://www.vpnbook.com/freevpn" > tmp_file

# get title
title=$(cat tmp_file | grep "title>" | cut --delimiter ">" --fields 2 | cut --delimiter "<" --fields 1)

# get description
desc=$(cat tmp_file | grep "description" | cut --delimiter '"' --fields 4 )

# write book data into the CSV file
echo -e "$title\n$desc" >> extractData.csv
