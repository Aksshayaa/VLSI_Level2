
# Task 1: Parameterized RTL Module

## Objective

Design and verify a parameterized up/down counter using Verilog HDL.

## Design Description

The design implements a synchronous up/down counter with configurable width.

### Features

- Parameterized counter width
- Synchronous active-high reset
- Enable input
- Direction control:
  - `1`: Count up
  - `0`: Count down
- Automatic rollover and underflow according to the configured width

## RTL Configuration

- Default counter width: 8 bits
- Testbench counter width: 4 bits

The 4-bit testbench configuration verifies counting from 0 to 15 and the corresponding rollover and underflow behavior.

## Verification

The testbench checks:

- Reset operation
- Up-counting
- Down-counting
- Enable control
- Maximum count rollover
- Minimum count underflow

**Simulation result:** All implemented counter test cases passed.

## Tools Used

- Verilog HDL
- Icarus Verilog
- GTKWave

## Files

- `RTL/up_down_counter.v`: Counter RTL implementation
- `TB/tb_up_down_counter.v`: Verification testbench
- `Results/counter_sim`: Compiled simulation executable
- `Results/counter_waveform.vcd`: Simulation waveform

## Simulation Commands

```bash
iverilog -g2012 -o Results/counter_sim RTL/up_down_counter.v TB/tb_up_down_counter.v

vvp Results/counter_sim
```

## Conclusion

Successfully designed and simulated a parameterized up/down counter. The project demonstrates parameterized RTL coding, synchronous control logic and functional verification.
