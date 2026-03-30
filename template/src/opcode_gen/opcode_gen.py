import re
import os

def get_params_from_tb():
    """
    Searches for tb.v in the current folder and common Vivado paths.
    Parses LEN_X and LEN_Y parameters.
    """
    # List of likely paths for tb.v in a Vivado project structure
    possible_paths = [
        "tb.v",
        "project_1/project_1.srcs/sim_1/new/tb.v",
        "../sim/tb.v"
    ]
    
    content = None
    for path in possible_paths:
        if os.path.exists(path):
            with open(path, "r") as f:
                content = f.read()
            print(f"--- Found testbench at: {path} ---")
            break
            
    if not content:
        return None, None

    # Robust regex to find 'parameter LEN_X = VALUE;' even with comments
    lx_match = re.search(r"parameter\s+LEN_X\s*=\s*(\d+)", content)
    ly_match = re.search(r"parameter\s+LEN_Y\s*=\s*(\d+)", content)
    
    if lx_match and ly_match:
        lx = int(lx_match.group(1))
        ly = int(ly_match.group(1))
        # Formula: Lh = Ly - Lx + 1
        lh = ly - lx + 1
        return lx, lh
    
    return None, None

# 1. AUTO-DETECTION
LEN_X, LEN_H = get_params_from_tb()

if LEN_X is None:
    print("Warning: Could not find parameters in tb.v. Using default (8, 8).")
    LEN_X, LEN_H = 8, 8
else:
    print(f"Success! Detected: LEN_X={LEN_X}, target LEN_H={LEN_H}")

# 2. ISA DEFINITION
OPCODES = {
    "NOP": "0000", "CLR": "0001", "INC": "0010", "ADD_64": "0011", 
    "ADD_128": "0100", "LOAD": "0101", "STORE": "0110", "L_ACC_H": "0111", 
    "L_ACC_L": "1000", "MAC": "1001", "DIV": "1010", "MOV": "1011", "HLT": "1100"
}
REGS = {"R0": "00", "R1": "01", "R2": "10", "R3": "11"}
program = []

def get_addr(addr, reg):
    prog = [("CLR", reg, "R0")]
    if addr >= 128:
        prog.append(("ADD_128", reg, reg))
        addr -= 128
    if addr >= 64:
        prog.append(("ADD_64", reg, reg))
        addr -= 64
    for _ in range(addr):
        prog.append(("INC", reg, reg))
    return prog

# 3. ASSEMBLY GENERATION
for n in range(LEN_H):
    # Load y[n] (Sector 2: 64-127)
    program.extend(get_addr(64 + 2*n, "R0"))
    program.append(("NOP", "R0", "R0"))
    program.append(("LOAD", "R1", "R0"))
    program.append(("L_ACC_H", "R0", "R1"))
    
    program.append(("INC", "R0", "R0"))
    program.append(("NOP", "R0", "R0"))
    program.append(("LOAD", "R1", "R0"))
    program.append(("L_ACC_L", "R0", "R1"))

    # MAC Loop: y[n] - sum(x[i] * h[n-i])
    for i in range(1, min(n + 1, LEN_X)):
        program.extend(get_addr(i, "R0"))
        program.append(("NOP", "R0", "R0"))
        program.append(("LOAD", "R1", "R0"))
        
        program.extend(get_addr(128 + (n - i), "R0"))
        program.append(("NOP", "R0", "R0"))
        program.append(("LOAD", "R2", "R0"))
        
        program.append(("MAC", "R1", "R2"))

    # Final Division and Storage
    program.extend(get_addr(0, "R0"))
    program.append(("NOP", "R0", "R0"))
    program.append(("LOAD", "R1", "R0")) 
    program.append(("DIV", "R2", "R1"))  
    
    program.extend(get_addr(128 + n, "R0"))
    program.append(("STORE", "R2", "R0")) 

program.append(("HLT", "R0", "R0"))

with open("program.mem", "w") as f:
    for op, r1, r2 in program:
        f.write(OPCODES[op] + REGS[r1] + REGS.get(r2, "00") + "\n")

print(f"Successfully generated {len(program)} instructions in program.mem.")
