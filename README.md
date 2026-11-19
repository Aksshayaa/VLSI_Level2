# VLSI Level 2: RTL Design, Synthesis and Verification

## Overview

This repository contains three RTL engineering tasks completed as part of my VLSI internship assignment.

The work covers parameterized RTL design, logic synthesis using Yosys, and FSM-based verification using Verilog HDL.

## Tools Used

- Verilog HDL
- Icarus Verilog 12.0
- GTKWave 3.3.100
- Yosys 0.52
- Visual Studio Code
- Ubuntu on WSL

## Tasks Completed

### Task 1: Parameterized RTL Module

Designed and verified a parameterized up/down counter.

- Configurable counter width
- Synchronous active-high reset
- Enable control
- Up-counting and down-counting modes
- Testbench-based functional verification

### Task 2: RTL-to-Synthesis Flow

Designed a 4-bit Arithmetic Logic Unit and synthesized it using Yosys.

- Addition and subtraction
- AND, OR and XOR operations
- Carry/borrow and zero flag generation
- Synthesized Verilog netlist
- Synthesis statistics report
- Automated synthesis script

### Task 3: FSM Verification and Data Flow

Designed a four-state controller with an integrated datapath.

- IDLE, LOAD, PROCESS and DONE states
- Input data capture
- 4-bit addition datapath
- Reset verification
- Legal state-transition verification
- Illegal-state recovery
- GTKWave waveform analysis
- Explicit SystemVerilog assertion-based verification.
- FSM state-transition and datapath-flow diagrams.

## Repository Structure

```text
VLSI_Level2/
│
├── README.md
├── Screenshots/
│   ├── task1_sim.png
│   ├── task2_output.png
│   ├── task2_sim.png
│   ├── task3_output.png
│   └── task3_sim.png
│
├── Task1_Parameterized_RTL/
│   ├── RTL/
│   ├── TB/
│   └── Results/
│
├── Task2_RTL_Synthesis/
│   ├── RTL/
│   ├── TB/
│   ├── Scripts/
│   └── Reports/
│
└── Task3_FSM_Verification/
    ├── FSM_State_Dataflow.md
    ├── RTL/
    ├── TB/
    ├── Waveforms/
    └── Results/

## Verification Summary

| Task   | Verification                                            |
| ------ | --------------------------------------                  |
| Task 1 | Counter simulation passed                               |
| Task 2 | 7 ALU test cases passed                                 |
| Task 2 | Yosys synthesis completed successfully                  |
| Task 3 | All FSM assertions and verification checks passed       |

## Screenshots and Verification Evidence

The `Screenshots/` directory contains visual evidence of the simulation waveforms, functional verification results and RTL synthesis output for all three tasks.

- Task 1: Counter simulation and waveform
- Task 2: ALU simulation, waveform and Yosys synthesis
- Task 3: FSM simulation and waveform

## Assertions and State/Data Flow Diagram

The testbench uses SystemVerilog immediate assertions to verify:

- Reset outputs and IDLE state
- Legal FSM state transitions
- Input capture in reg_a and reg_b
- Correct arithmetic result
- DONE signal assertion
- Illegal-state recovery
- Reset recovery during operation

The FSM state-transition and datapath-flow diagrams
are documented in FSM_State_Dataflow.md.

Final simulation result:
ALL FSM ASSERTIONS AND TESTS PASSED!

## Learning Outcomes

Through these tasks, I gained practical experience in:

- Writing synthesizable Verilog RTL
- Designing parameterized hardware modules
- Developing simulation testbenches
- Understanding FSM-based control logic
- Performing RTL synthesis using Yosys
- Inspecting synthesized netlists and cell statistics
- Analyzing digital waveforms using GTKWave

---

**Project Focus:** RTL Design | Digital Logic | Synthesis | Functional Verification
