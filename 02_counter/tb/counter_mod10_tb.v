`timescale 1ns/1ps

module counter_mod10_tb;

reg clk;
reg reset;
reg en;
wire [3:0] count;

counter_mod10 uut (
    .clk(clk),
    .reset(reset),
    .en(en),
    .count(count)
);

always #5 clk = ~clk;

initial begin
    clk   = 0;
    reset = 1;
    en    = 0;

    #12 reset = 0;

    en = 1;
    #150;

    en = 0;
    #30;

    en = 1;
    #60;

    reset = 1;
    #10;
    reset = 0;

    #30 $stop;
end

endmodule