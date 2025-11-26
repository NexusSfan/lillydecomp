# SPDX-License-Identifier: CC0-1.0

import sys
import re

file = sys.argv[1]

with open(file, encoding="utf-8") as f:
    lines = f.readlines()

all_funcs_undoc = ["".join(line.split()) for line in lines if re.search(r"^Lf[a-z0-9]{3}$", line)]

TOTAL_FUNCS = 215

all_funcs = TOTAL_FUNCS - len(all_funcs_undoc)

print(f"{all_funcs}/{TOTAL_FUNCS} functions documented")

all_vars_undoc = ["".join(line.split()) for line in lines if line.startswith("ram_")]

TOTAL_VARS = 90

all_vars = TOTAL_VARS - len(all_vars_undoc)

print(f"{all_vars}/{TOTAL_VARS} variables documented")

func_percent_raw = str(all_funcs/TOTAL_FUNCS)
if len(func_percent_raw) == 3:
    func_percent_raw = f"{func_percent_raw}0"

var_percent_raw = str(all_vars/TOTAL_VARS)
if len(var_percent_raw) == 3:
    var_percent_raw = f"{var_percent_raw}0"

func_percent = int(func_percent_raw[2:4])
var_percent = int(var_percent_raw[2:4])

print(f"{func_percent}% of functions are documented. {var_percent}% of variables are documented.")

total_progress_raw = int(int(func_percent) + int(var_percent)) / 200
total_progress = int(str(total_progress_raw)[2:4])

print(f"Total progress: {total_progress}%")