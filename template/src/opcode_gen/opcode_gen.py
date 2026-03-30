
# you can define your own opcodes here!!
OPCODES = {
    "NOP":       "0000",
    "MAC":       "0001",
    "LOAD_RAM":  "0010",
    "STORE_RAM": "0011",
    "LOAD_REG":  "0100",
    "STORE_REG": "0101",
}
 
# Register table do not change this!! no. of registers are constant.
REGS = {
    "R0": "00",
    "R1": "01",
    "R2": "10",
    "R3": "11",
}
 
# ── Write your program here ──────────────────────────────────────────────────
program = [
    ("NOP",       "R0", "R0"),
    ("MAC",       "R1", "R2"),
    ("MAC",       "R0", "R3"),
    ("STORE_RAM", "R1", "R0"),
    ("LOAD_RAM",  "R3", "R0"),
    ("LOAD_REG",  "R2", "R1"),
    ("STORE_REG", "R3", "R2"),
    ("MAC",       "R3", "R2"),
    ("NOP",       "R0", "R0"),
]
 
# ── Convert and print ────────────────────────────────────────────────────────
print(f"{'PC':<5} {'Mnemonic':<25} {'Binary'}")
print("-" * 45)
 
with open("program.asm", "w") as f:
    for i, (op, r1, r2) in enumerate(program):
        binary = OPCODES[op] + REGS[r1] + REGS[r2]
        print(f"PC={i:<3} {op+' '+r1+','+r2:<25} {binary}")
        f.write(binary + "\n")
 
print("-" * 45)
print(f"Total: {len(program)} instructions written to program.asm")