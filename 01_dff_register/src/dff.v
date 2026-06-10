//DFF module
`timescale 1ns/1ps
module dff (
    input  wire clk,
    input  wire d,
    input wire en,
    input wire rst,
    output reg  q
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        q <= 1'b0;
    end else if (en) begin
        q <= d;
    end
end

endmodule