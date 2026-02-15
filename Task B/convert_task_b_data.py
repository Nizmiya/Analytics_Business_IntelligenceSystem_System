#!/usr/bin/env python3
"""
Task B: Convert Excel file to CSV for tourist arrivals visualization
Creates SL_Tourists-2025.csv with Country and Total Arrivals only
"""

import os
import pandas as pd

# Paths relative to project root (ABI_System)
script_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.dirname(script_dir)

excel_file = os.path.join(project_root, 'Docs', 'ABI-CIS6008-SEP-2025-Dataset', 'Question-(b)', 'All_Countries_Jan_August_2025.xlsx')
print("Reading Excel file...")

# Read without header to see raw structure
df_raw = pd.read_excel(excel_file, sheet_name='All Country', header=None)

# The actual data starts at row 2 (0-indexed), with headers at row 2
# Columns: Rank (1), Country (2), Jan-Aug months, Total (11)
df = pd.read_excel(excel_file, sheet_name='All Country', header=2)

print(f"Original shape: {df.shape}")
print("\nColumn names:")
print(df.columns.tolist())

# Clean up column names - remove any unnamed columns
df = df.loc[:, ~df.columns.str.contains('^Unnamed')]

print("\nAfter removing unnamed columns:")
print(df.columns.tolist())
print(f"\nShape: {df.shape}")

# Display first few rows
print("\nFirst 10 rows:")
print(df.head(10))

# Create the required CSV file with only Country and Total columns
# Select Country and Total columns
sl_tourists = df[['Country', 'Total']].copy()

# Remove any rows with NaN values
sl_tourists = sl_tourists.dropna()

# Clean country names (remove extra spaces)
sl_tourists['Country'] = sl_tourists['Country'].str.strip()

# Rename columns for clarity
sl_tourists.columns = ['Country_Name', 'Total_Tourists_Arrivals']

# Ensure Total is numeric
sl_tourists['Total_Tourists_Arrivals'] = pd.to_numeric(
    sl_tourists['Total_Tourists_Arrivals'], errors='coerce'
)

# Remove any rows where Total is 0 or NaN
sl_tourists = sl_tourists[sl_tourists['Total_Tourists_Arrivals'] > 0]

# Sort by Total arrivals (descending) for better visualization
sl_tourists = sl_tourists.sort_values('Total_Tourists_Arrivals', ascending=False)

# Reset index
sl_tourists = sl_tourists.reset_index(drop=True)

print(f"\n\nFinal CSV shape: {sl_tourists.shape}")
print(f"Total countries: {len(sl_tourists)}")
print(f"\nTotal tourist arrivals: {sl_tourists['Total_Tourists_Arrivals'].sum():,.0f}")

print("\nTop 10 countries by arrivals:")
print(sl_tourists.head(10))

print("\nBottom 10 countries by arrivals:")
print(sl_tourists.tail(10))

print("\nStatistics:")
print(sl_tourists['Total_Tourists_Arrivals'].describe())

# Save to CSV (Task B folder)
output_file = os.path.join(script_dir, 'SL_Tourists-2025.csv')
sl_tourists.to_csv(output_file, index=False)
print(f"\n[OK] CSV file created: {output_file}")

# Also save the full data for reference (Task B folder)
full_output = os.path.join(script_dir, 'All_Countries_Full_Data_2025.csv')
df.to_csv(full_output, index=False)
print(f"[OK] Full data CSV created: {full_output}")

print("\n" + "="*60)
print("Data Conversion Complete!")
print("="*60)
