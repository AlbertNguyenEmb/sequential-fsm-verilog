`timescale 1ns/1ps

module universal_shift_register_tb;

reg clk;
reg reset;
reg [1:0] mode;
reg serial_in_left;
reg serial_in_right;
reg [3:0] parallel_in;

wire [3:0] parallel_out;
wire serial_out_left;
wire serial_out_right;

universal_shift_register #(
    .WIDTH(4)
) uut (
    .clk(clk),
    .reset(reset),
    .mode(mode),
    .serial_in_left(serial_in_left),
    .serial_in_right(serial_in_right),
    .parallel_in(parallel_in),
    .parallel_out(parallel_out),
    .serial_out_left(serial_out_left),
    .serial_out_right(serial_out_right)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    reset = 1;
    mode = 2'b00;
    serial_in_left = 0;
    serial_in_right = 0;
    parallel_in = 4'b0000;

    #12 reset = 0;

    // PIPO / Parallel Load
    parallel_in = 4'b1011;
    mode = 2'b11;
    #10;

    // Hold
    mode = 2'b00;
    parallel_in = 4'b1111;
    #20;

    // PISO: Shift right and read serial_out_right
    mode = 2'b01;
    serial_in_right = 0;
    #10;
    #10;
    #10;
    #10;

    // Load again
    parallel_in = 4'b1100;
    mode = 2'b11;
    #10;

    // Shift left
    mode = 2'b10;
    serial_in_left = 1;
    #10;
    serial_in_left = 0;
    #10;
    serial_in_left = 1;
    #10;

    // SIPO example: reset then shift serial bits in
    reset = 1;
    #10;
    reset = 0;

    mode = 2'b01; // shift right
    serial_in_right = 1;
    #10;
    serial_in_right = 0;
    #10;
    serial_in_right = 1;
    #10;
    serial_in_right = 1;
    #10;

    mode = 2'b00;
    #20;

    $finish;
end

endmodule