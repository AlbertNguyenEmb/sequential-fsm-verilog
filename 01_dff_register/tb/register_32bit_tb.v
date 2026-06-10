`timescale 1ns/1ps
module register_32bit_tb();

reg clk;
reg [31:0] d;
wire [31:0] q;
reg en;
reg rst;

register_32bit uut (
    .clk(clk),
    .d(d),
    .q(q),
    .en(en),
    .rst(rst)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    rst = 1;
    en    = 0;
    d     = 32'h0000_0000;

    #12 rst = 0;

    #10 d = 32'h1234_5678;
    #10 d = 32'hAAAA_BBBB;

    #5 en = 1;
    #10 d = 32'hDEAD_BEEF;
    #10 d = 32'hCAFE_BABE;
    #10 d = 32'h0000_1111;

    #10 en = 0;
    #10 d = 32'hFFFF_FFFF;

    #10 rst = 1;
    #10 rst = 0;

    #20 $stop;
end


endmodule