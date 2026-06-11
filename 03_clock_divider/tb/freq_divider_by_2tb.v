`timescale 1ns/1ps
module freq_divider_by_2_tb();
reg clk_in;
reg reset;
wire clk_out;

freq_divider_by_2 uut(
    .clk_in(clk_in),
    .reset(reset),
    .clk_out(clk_out)
);
always #5 clk_in = ~clk_in;
initial begin
    clk_in = 1'b0;
    reset = 1;
    #12;
    reset = 0;
    clk_in = 1;
    #200;
    $stop;
end
endmodule