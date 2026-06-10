# Project 01: D Flip-Flop and Register

## Objective

This project implements basic sequential circuits in Verilog:
- D Flip-Flop
- D Flip-Flop with enable
- D Flip-Flop with asynchronous reset and enable
- 8-bit register
- 32-bit register

## Key Concepts

- Clocked sequential logic
- Positive-edge triggered flip-flop
- Asynchronous reset
- Enable signal
- Data storage using registers
- Verilog testbench and waveform verification

## Modules

| Module | Description |
|---|---|
| dff.v |D Flip-Flop with reset and enable |
| register_32bit.v | 32-bit register |

## Expected Behavior

- When reset is high, output is cleared to zero.
- When enable is high, output captures input data at the rising edge of clock.
- When enable is low, output holds the previous value.

## Simulation

Example command:

```tcl
vlib work
vlog src/register_8bit.v tb/register_8bit_tb.v
vsim register_8bit_tb
add wave -r *
run -all
