# Quaternary Multiple-Valued Logic Processor

A complete Verilog implementation of a quaternary (base-4) Multiple-Valued Logic (MVL) processor, built from first-principles standard cells through a full pipelined CPU.

Implemented as part of undergraduate research under **Prof. Tapas Kumar Maiti**, Dhirubhai Ambani University.

## Overview

This project synthesizes techniques from four research papers into a working quaternary processor:

* Romero et al. (2014) — Universal CMOS gate set for MVL
* Sooriamala & Poovannan (2017) — Quaternary adder and multiplexer synthesis
* Gouveia et al. (2020) — Pipelined quaternary processor architecture
* Fortugno (1996) — Current-mode MVL standard cell library

## Architecture

```text
Standard Cells
      ↓
Arithmetic Units
(Half Adder, Full Adder, 4-Digit Adder)
      ↓
ALU (8 Operations)
      ↓
Register File + Instruction Memory + Control Unit
      ↓
Pipelined CPU
```

## Key Results

The processor computes the Fibonacci sequence using quaternary logic, matching the results reported by Gouveia et al. (2020).

```text
Quaternary:  0, 1, 1, 2, 3, 11, 20, 31, 111, 202...
Decimal:     0, 1, 1, 2, 3, 5,  8,  13, 21,  34...
```

## How to Run

Requires [Icarus Verilog](http://iverilog.icarus.com/).

From the project root directory, compile the processor using:

```bash
iverilog -o sim.out \
testbenches/tb_cpu16.v \
processor/quat_cpu16.v \
processor/quat_imem16.v \
processor/quat_control16.v \
processor/quat_regfile.v \
alu/quat_alu_wide.v \
arithmetic/quat_add4.v \
arithmetic/quat_full_adder.v \
arithmetic/quat_half_adder.v \
cells/quat_max.v \
cells/quat_min.v \
cells/quat_suc.v \
cells/eAND1.v \
cells/eAND2.v \
cells/eAND3.v \
cells/quat_tsum.v
```

Run the simulation:

```bash
vvp sim.out
```

## Instruction Set

| Opcode | Operation | Format                         |
| ------ | --------- | ------------------------------ |
| `0000` | ADD       | `rd = rs1 + rs2`               |
| `0001` | MAX       | `rd = max(rs1, rs2)`           |
| `0010` | MIN       | `rd = min(rs1, rs2)`           |
| `0011` | MOV       | `rd = rs1`                     |
| `0100` | TSUM      | `rd = truncated_sum(rs1, rs2)` |
| `0101` | CMP       | `rd = (rs1 > rs2)`             |
| `0110` | NOP       | No operation                   |

### 16-bit Instruction Format

```text
[ opcode (4) ][ rs1 (4) ][ rs2 (4) ][ rd (4) ]
```

## References

1. M. E. R. Romero et al., "Universal Set of CMOS Gates for the Synthesis of Multiple Valued Logic Digital Circuits," *IEEE Transactions on Circuits and Systems I*, vol. 61, no. 3, 2014.

2. A. P. Sooriamala and E. Poovannan, "Synthesis of Multiple Valued Logic Digital Circuits using CMOS Gates," *IEEE ICIEEIMT*, 2017.

3. T. Gouveia et al., "Four Stage Pipeline Quaternary Processor," *Ingeniare. Revista Chilena de Ingeniería*, vol. 28, no. 3, 2020.

4. V. M. Fortugno, "Design and Test of an MVL CMOS Standard Cell Library," M.S. thesis, University of Saskatchewan, 1996.

## Author

**Vrinda Goradia**
B.Tech Electronics and VLSI Design
Dhirubhai Ambani University
Undergraduate Researcher — Prof. Tapas Kumar Maiti
