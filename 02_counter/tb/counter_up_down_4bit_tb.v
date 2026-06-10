`timescale 1ns/1ps
module counter_up_down_4bit_tb();
reg clk;
reg reset;
reg en;
reg dir;
wire [3:0] count;

counter_up_down_4bit uut (
    .clk(clk),
    .reset(reset),
    .en(en),
    .dir(dir),
    .count(count)
);

always #5 clk = ~clk;
initial begin
    clk = 0;
    reset = 1;
    en = 0;
    dir = 1;

    #12 reset = 0;

    // Đếm lên
    #8 en = 1;
    dir = 1;
    #160;

    // Đếm xuống
    dir = 0;
    #80;

    // Dừng counter
    en = 0;
    #30;

    // Đếm lên lại
    en = 1;
    dir = 1;
    #50;

    // Reset
    reset = 1;
    #10;
    reset = 0;

    #30 $stop;
end
endmodule