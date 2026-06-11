`timescale 1ns/1ps

module slow_counter_tick_tb;

reg clk;
reg reset;
wire [3:0] count;

slow_counter_tick #(
    .MAX_COUNT(5)
) uut (
    .clk(clk),
    .reset(reset),
    .count(count)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    reset = 1;

    #12 reset = 0;

    #250;

    reset = 1;
    #10;
    reset = 0;

    #100;

    $finish;
end

endmodule