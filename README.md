# Project 03: Clock Divider and Tick Generator

## Objective

This project implements clock divider and tick generator circuits in Verilog.

## Key Concepts

- Counter-based timing
- Clock division
- Tick enable generation
- LED blinking using tick
- Slow counter using tick
- Avoiding generated clocks in FPGA design

## Modules

| Module | Description |
|---|---|
| tick_generator.v | Generates a one-clock-cycle tick every N clock cycles |
| clock_divider.v | Generates a slower clock by toggling output |
| led_blink_tick.v | Toggles LED on each tick |
| slow_counter_tick.v | Counter that increments only when tick is high |

## Important Note

For FPGA design, using a tick enable is usually preferred over creating a new derived clock.

Instead of:

```verilog
always @(posedge slow_clk)
