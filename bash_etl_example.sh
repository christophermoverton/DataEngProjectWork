
#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input_file> <output_file>"
    exit 1
fi

# Set input and output file paths from command line arguments
input_file=$1
output_file=$2

# ETL Process
echo "Extracting data from $input_file..."
# Assuming the CSV has a header
tail -n +2 "$input_file" | sort -t',' -k3,3 > temp_sorted_data.csv

echo "Loading sorted data into $output_file..."
# Add headers back to the sorted data
{ head -n 1 "$input_file"; cat temp_sorted_data.csv; } > "$output_file"

# Clean up temporary files
rm temp_sorted_data.csv

echo "ETL process completed."