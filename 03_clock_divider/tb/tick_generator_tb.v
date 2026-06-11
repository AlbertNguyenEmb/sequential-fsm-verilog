`timescale 1ns/1ps

module tick_generator_tb;

reg clk;
reg reset;
wire tick;

tick_generator #(
    .MAX_COUNT(5)
) uut (
    .clk(clk),
    .reset(reset),
    .tick(tick)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    reset = 1;

    #12 reset = 0;

    #150;

    reset = 1;
    #10;
    reset = 0;

    #80;

    $stop;
end

endmodule