`timescale 1ns/1ps
module freq_divider_by_2 (
    input clk_in,
    input reset,
    output reg clk_out
);

always @(posedge clk_in or posedge reset) begin
    if (reset) begin
        clk_out <= 1'b0;
    end else begin
        clk_out <= ~clk_out;
    end
end
endmodule