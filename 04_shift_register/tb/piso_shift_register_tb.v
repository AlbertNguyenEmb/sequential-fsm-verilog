`timescale 1ns/1ps

module piso_shift_register_tb;

reg clk;
reg reset;
reg load;
reg shift_en;
reg serial_in;
reg [3:0] parallel_in;
wire serial_out;

piso_shift_register #(
    .WIDTH(4)
) uut (
    .clk(clk),
    .reset(reset),
    .load(load),
    .shift_en(shift_en),
    .serial_in(serial_in),
    .parallel_in(parallel_in),
    .serial_out(serial_out)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    reset = 1;
    load = 0;
    shift_en = 0;
    serial_in = 0;
    parallel_in = 4'b0000;

    #12 reset = 0;

    // Load parallel data
    parallel_in = 4'b1011;
    load = 1;
    #10;

    // Shift out data
    load = 0;
    shift_en = 1;
    serial_in = 0;

    #10;
    #10;
    #10;
    #10;

    shift_en = 0;
    #20;

    #20 $finish;
end

endmodule