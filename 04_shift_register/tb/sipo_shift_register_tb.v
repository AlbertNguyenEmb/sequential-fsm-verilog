`timescale 1ns/1ps

module sipo_shift_register_tb;

reg clk;
reg reset;
reg en;
reg serial_in;
wire [3:0] parallel_out;

sipo_shift_register #(
    .WIDTH(4)
) uut (
    .clk(clk),
    .reset(reset),
    .en(en),
    .serial_in(serial_in),
    .parallel_out(parallel_out)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    reset = 1;
    en = 0;
    serial_in = 0;

    #12 reset = 0;
    en = 1;

    #10 serial_in = 1;
    #10 serial_in = 0;
    #10 serial_in = 1;
    #10 serial_in = 1;

    #30;

    en = 0;
    #20;

    #20 $finish;
end

endmodule