`timescale 1ns/1ps

module clock_divider_tb;

reg clk;
reg reset;
wire slow_clk;

clock_divider #(
    .DIVIDE_BY(10)
) uut (
    .clk(clk),
    .reset(reset),
    .slow_clk(slow_clk)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    reset = 1;

    #12 reset = 0;

    #300;

    reset = 1;
    #10;
    reset = 0;

    #100;

    $finish;
end

endmodule