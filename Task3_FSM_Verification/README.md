
# Task 3: FSM Verification and Data Flow

## Objective

Design a finite state machine integrated with a small datapath and verify its functionality using a Verilog testbench.

## Design Description

The design implements a four-state controller that captures two 4-bit input operands, performs addition and signals completion.

### FSM States

| State   | Encoding | Function                 |
| ------- | -------- | ------------------------ |
| IDLE    | 000      | Wait for start signal    |
| LOAD    | 001      | Capture input operands   |
| PROCESS | 010      | Add stored operands      |
| DONE    | 011      | Assert completion signal |

The FSM uses a 3-bit state register, leaving unused encodings available for illegal-state recovery testing.

## Datapath Description

The datapath contains:

- `reg_a`: First 4-bit operand register
- `reg_b`: Second 4-bit operand register
- Adder: Performs addition
- `result`: Stores the 4-bit output

Example:

```text
data_a = 5
data_b = 7

result = 5 + 7 = 12
```

The result is stored in a 4-bit register, so overflow beyond four bits is discarded.

## Verification Strategy

The testbench verifies:

1. Reset functionality
2. IDLE state behavior
3. IDLE-to-LOAD transition
4. LOAD-to-PROCESS transition
5. PROCESS-to-DONE transition
6. Datapath addition result
7. DONE signal assertion and return to IDLE
8. Illegal-state recovery
9. Reset recovery during operation

## Verification Results

All eight implemented verification checks passed.

**Final simulation output:**

`ALL FSM TESTS PASSED!`

## Illegal-State Recovery

The testbench forces the internal state register to `3'b111`.

The FSM detects this unrecognized encoding through its default branch and returns to IDLE on the next active clock edge.

## Tools Used

- Verilog HDL
- Icarus Verilog
- GTKWave
- Visual Studio Code

## Files

- `RTL/fsm_datapath.v`: FSM and datapath implementation
- `TB/tb_fsm_datapath.v`: Verification testbench
- `Waveforms/fsm_waveform.vcd`: Simulation waveform
- `Results/fsm_sim`: Compiled simulation executable

## Simulation Commands

```bash
iverilog -g2012 -o Results/fsm_sim RTL/fsm_datapath.v TB/tb_fsm_datapath.v

vvp Results/fsm_sim
```

Open the waveform using:

```bash
gtkwave Waveforms/fsm_waveform.vcd
```

## Conclusion

Successfully designed and verified a four-state FSM with an integrated datapath. Functional verification covered reset behavior, legal state transitions, datapath operation, completion signaling and illegal-state recovery.
