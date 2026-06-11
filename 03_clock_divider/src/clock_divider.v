`timescale 1ns/1ps
module clock_divider #(
    parameter DIVIDE_BY = 10
)(
    input wire clk,
    input wire reset,
    output reg slow_clk
);

reg [31:0] count;
always @(posedge clk or posedge reset) begin
    if (reset) begin
        count <= 32'd0;
        slow_clk <= 1'b0;
    end
    else begin
        if (count == (DIVIDE_BY/2) - 1) begin
            count <= 32'd0;
            slow_clk <= ~slow_clk;
        end else begin
            count <= count + 1'b1;
        end
    end
end
    
endmodule