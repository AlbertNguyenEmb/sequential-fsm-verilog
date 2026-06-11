`timescale 1ns/1ps
module sipo_shift_register #(
    parameter WIDTH = 4
)(
    input wire clk,
    input wire reset,
    input wire serial_in,
    input wire en,
    output reg [WIDTH-1:0] parallel_out
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        parallel_out <= {WIDTH{1'b0}};
    end else if (en) begin
        parallel_out <= {serial_in, parallel_out[WIDTH-1:1]};
    end
end
    
endmodule