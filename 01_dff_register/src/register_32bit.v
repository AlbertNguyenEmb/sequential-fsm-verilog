`timescale 1ns/1ps
module register_32bit (
    input wire [31:0] d,
    output reg [31:0] q,
    input wire rst,
    input wire en,
    input wire clk
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        q <= 32'b0;
    end else if (en) begin
        q <= d;
    end
end
endmodule