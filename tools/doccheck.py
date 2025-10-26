import sys
import re

file = sys.argv[1]

with open(file, encoding="utf-8") as f:
    lines = f.readlines()

all_funcs = ["".join(line.split()) for line in lines if re.search(r"^Lf[a-z0-9]{3}$", line)]

TOTAL_FUNCS = 215

print(f"{len(all_funcs)}/{TOTAL_FUNCS} functions documented")

all_vars = ["".join(line.split()) for line in lines if line.startswith("ram_")]

TOTAL_VARS = 90

print(f"{len(all_vars)}/{TOTAL_VARS} variables documented")

func_percent_undoc = int(str(len(all_funcs)/TOTAL_FUNCS)[2:4])
var_percent_undoc = int(str(len(all_vars)/TOTAL_VARS)[2:4])

func_percent = 100 - func_percent_undoc
var_percent = 100 - var_percent_undoc

print(f"{func_percent}% of functions are documented. {var_percent}% of variables are documented.")
