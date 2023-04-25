import pandas as pd
import os

# Path to directory containing CSV files
csv_dir = "/home/omar/labs/lab1/input"
out_dir = "/home/omar/labs/lab1/output"

# List all CSV files in directory
csv_files = [f for f in os.listdir(csv_dir) if f.endswith('.csv')]

# Concatenate CSV files into a single DataFrame
df = pd.concat([pd.read_csv(os.path.join(csv_dir, f)) for f in csv_files], ignore_index=True)

# Save concatenated data to a new CSV file
df.to_csv(os.path.join(out_dir, "all_years.csv"), index=False)

