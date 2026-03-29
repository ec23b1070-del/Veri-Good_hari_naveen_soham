import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge

# Clock period (must match your Clock below)
CLK_PERIOD_NS = 10

# ---------------------------
# Reset
# ---------------------------
async def reset_dut(dut):
    dut.rst.value = 1
    for _ in range(5):
        await RisingEdge(dut.clk)
    dut.rst.value = 0

# ---------------------------
# Test: Pretty print cycle count
# ---------------------------
@cocotb.test()
async def test_cycle_count(dut):

    # Start clock
    cocotb.start_soon(Clock(dut.clk, CLK_PERIOD_NS, units="ns").start())

    dut.instr.value = 0

    await reset_dut(dut)

    # Run simulation for some cycles
    for _ in range(50):
        await RisingEdge(dut.clk)

    # Read final cycle count
    total_cycles = int(dut.cycle_count.value)

    # Convert to time
    total_time_ns = total_cycles * CLK_PERIOD_NS

    # ---------------------------
    # Pretty Print
    # ---------------------------
    cocotb.log.info("=" * 50)
    cocotb.log.info("⏱️  SIMULATION SUMMARY")
    cocotb.log.info("=" * 50)
    cocotb.log.info(f"Total Cycles   : {total_cycles}")
    cocotb.log.info(f"Clock Period   : {CLK_PERIOD_NS} ns")
    cocotb.log.info(f"Total Time     : {total_time_ns} ns")
    cocotb.log.info("=" * 50)