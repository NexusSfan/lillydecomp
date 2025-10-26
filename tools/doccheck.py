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

func_percent = int(str(all_funcs/TOTAL_FUNCS)[2:4])
var_percent = int(str(all_vars/TOTAL_VARS)[2:4])

print(f"{func_percent}% of functions are documented. {var_percent}% of variables are documented.")
