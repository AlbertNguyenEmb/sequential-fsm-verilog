`timescale 1ns/1ps

module siso_shift_register_tb;

reg clk;
reg reset;
reg en;
reg serial_in;
wire serial_out;

siso_shift_register #(
    .WIDTH(4)
) uut (
    .clk(clk),
    .reset(reset),
    .en(en),
    .serial_in(serial_in),
    .serial_out(serial_out)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    reset = 1;
    en = 0;
    serial_in = 0;

    #12 reset = 0;
    en = 1;

    // Shift in: 1 0 1 1
    #10 serial_in = 1;
    #10 serial_in = 0;
    #10 serial_in = 1;
    #10 serial_in = 1;

    // Continue shifting zeros
    #10 serial_in = 0;
    #10 serial_in = 0;
    #10 serial_in = 0;
    #10 serial_in = 0;

    #20 $finish;
end

endmodule