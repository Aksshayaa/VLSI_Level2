# Task 2: RTL-to-Synthesis Flow

## Objective

Design a 4-bit Arithmetic Logic Unit (ALU), synthesize the RTL using Yosys and inspect the resulting netlist and synthesis statistics.

## Design Description

The ALU accepts two 4-bit operands and a 3-bit operation code.

### Supported Operations

| Opcode | Operation           |
| ------ | ------------------- |
| 000    | Addition            |
| 001    | Subtraction         |
| 010    | Bitwise AND         |
| 011    | Bitwise OR          |
| 100    | Bitwise XOR         |
| Others | Default output zero |

### Output Signals

- `result`: 4-bit operation result
- `carry_out`: Arithmetic carry for addition and unsigned borrow indicator for subtraction
- `zero`: Asserted when the result is zero

## Synthesis Flow

The design was synthesized using Yosys.

The synthesis script performs:

1. RTL file reading
2. Hierarchy checking
3. Logic synthesis
4. Design consistency checking
5. Synthesized Verilog netlist generation
6. Synthesis statistics reporting

## Synthesis Results

Yosys completed synthesis successfully.

Selected statistics:

| Parameter    | Result |
| ------------ | -----: |
| Wires        |    106 |
| Wire bits    |    117 |
| Public wires |      6 |
| Ports        |      6 |
| Port bits    |     17 |
| Cells        |    106 |
| Memories     |      0 |

### Inferred Cell Statistics

| Cell type | Count |
| --------- | ----: |
| ANDNOT    |    51 |
| AND       |     6 |
| NAND      |     4 |
| NOR       |     5 |
| NOT       |     2 |
| ORNOT     |     7 |
| OR        |    21 |
| XNOR      |     2 |
| XOR       |     8 |

Yosys also reported zero design consistency problems during the `check` pass.

*Note: These are generic logic-cell statistics from the Yosys synthesis flow, not mapped standard-cell area or physical implementation results.*

## Functional Verification

Seven ALU test cases were executed.

- Addition with overflow
- Normal subtraction
- Subtraction with borrow
- AND operation
- OR operation
- XOR operation
- Invalid opcode handling

**Simulation result: ALL ALU TESTS PASSED!**

## Files

- `RTL/alu_4bit.v`: ALU RTL implementation
- `TB/tb_alu_4bit.v`: ALU testbench
- `Scripts/synth.ys`: Yosys synthesis script
- `Reports/alu_4bit_netlist.v`: Synthesized Verilog netlist
- `Reports/synthesis_report.txt`: Synthesis statistics
- `Reports/alu_waveform.vcd`: ALU simulation waveform

## Simulation Commands

```bash
iverilog -g2012 -o Reports/alu_sim RTL/alu_4bit.v TB/tb_alu_4bit.v

vvp Reports/alu_sim
```

## Synthesis Command

Run from the `Task2_RTL_Synthesis` directory in WSL:

```bash
yosys -s Scripts/synth.ys
```

## Conclusion

Successfully designed and functionally verified a 4-bit ALU and completed its RTL-to-synthesis flow using Yosys. The synthesized netlist and cell statistics were generated and inspected.
