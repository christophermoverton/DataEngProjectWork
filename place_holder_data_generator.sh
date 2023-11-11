#!/bin/bash

# Output file
OUTPUT_FILE="dummy_data.csv"

# Number of entries
NUM_ENTRIES=100

# Column names
COLUMNS=("ID" "Name" "Age" "City" "Country" "Salary" "Date")

# Generate header
echo "${COLUMNS[@]}" | tr ' ' ',' > $OUTPUT_FILE

# Generate random data and append to the file
for ((i = 1; i <= NUM_ENTRIES; i++)); do
    ID=$((i))
    Name="Person_$i"
    Age=$((RANDOM % 40 + 18))
    City=("CityA" "CityB" "CityC" "CityD" "CityE")
    RandomCity=${City[$((RANDOM % ${#City[@]}))]}
    Country=("CountryX" "CountryY" "CountryZ")
    RandomCountry=${Country[$((RANDOM % ${#Country[@]}))]}
    Salary=$((RANDOM % 50000 + 30000))
    Date=$(date -d "$((RANDOM % 365)) days ago" +"%Y-%m-%d")

    # Append data to the file
    echo "$ID,$Name,$Age,$RandomCity,$RandomCountry,$Salary,$Date" >> $OUTPUT_FILE
done

echo "Dummy CSV file created: $OUTPUT_FILE"