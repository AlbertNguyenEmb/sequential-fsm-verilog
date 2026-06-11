`timescale 1ns/1ps

module pipo_register_tb;

reg clk;
reg reset;
reg load;
reg [3:0] parallel_in;
wire [3:0] parallel_out;

pipo_register #(
    .WIDTH(4)
) uut (
    .clk(clk),
    .reset(reset),
    .load(load),
    .parallel_in(parallel_in),
    .parallel_out(parallel_out)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    reset = 1;
    load = 0;
    parallel_in = 4'b0000;

    #12 reset = 0;

    parallel_in = 4'b1010;
    load = 1;
    #10;

    load = 0;
    parallel_in = 4'b1111;
    #20;

    load = 1;
    #10;

    load = 0;
    #20;

    reset = 1;
    #10;
    reset = 0;

    #20 $finish;
end

endmodule