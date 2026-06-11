# Project 04: Shift Registers in Verilog

## Objective

This project implements several types of shift registers in Verilog:
- SISO: Serial In Serial Out
- SIPO: Serial In Parallel Out
- PISO: Parallel In Serial Out
- PIPO: Parallel In Parallel Out
- Universal Shift Register

## Key Concepts

- Sequential logic
- Shift operation
- Serial input/output
- Parallel input/output
- Hold, shift left, shift right, and parallel load
- Register-based data movement

## Modules

| Module | Description |
|---|---|
| siso_shift_register.v | Serial input, serial output shift register |
| sipo_shift_register.v | Serial input, parallel output shift register |
| piso_shift_register.v | Parallel input, serial output shift register |
| pipo_register.v | Parallel input, parallel output register |
| universal_shift_register.v | Hold, shift right, shift left, parallel load |

## Universal Shift Register Modes

| Mode | Operation |
|---|---|
| 00 | Hold |
| 01 | Shift Right |
| 10 | Shift Left |
| 11 | Parallel Load |

## Simulation Example

```tcl
vlib work
vlog src/universal_shift_register.v tb/universal_shift_register_tb.v
vsim universal_shift_register_tb
add wave -r *
run -all