#!/usr/bin/env python3
"""
Read HOTELS_2025.csv from Docs/ABI-CIS6008-SEP-2025-Dataset/Question-(a)/,
convert HotelQualityRank values to 0, 1, 2; column name stays HotelQualityRank.
Save as HOTELS_2025.csv in Task_A folder.
"""

from pathlib import Path

import pandas as pd

# Task_A folder (where this script lives)
task_a_dir = Path(__file__).resolve().parent
# Project root (ABI_System)
project_root = task_a_dir.parent

# Source: Docs/.../Question-(a)/HOTELS_2025.csv
input_path = project_root / "Docs" / "ABI-CIS6008-SEP-2025-Dataset" / "Question-(a)" / "HOTELS_2025.csv"
output_path = task_a_dir / "HOTELS_2025.csv"

quality_mapping = {"Low": 0, "Medium": 1, "High": 2}

df = pd.read_csv(input_path)
if "HotelQualityRank" not in df.columns:
    raise KeyError("Column 'HotelQualityRank' not found.")

# Replace values only; column name stays HotelQualityRank
df["HotelQualityRank"] = df["HotelQualityRank"].map(quality_mapping)

df.to_csv(output_path, index=False)
print(f"Saved: {output_path}")
