`timescale 1ns/1ps
module siso_shift_register #(
    parameter WIDTH = 4
)(
    input wire clk,
    input wire reset,
    input wire en,
    input wire serial_in,
    output wire serial_out   
);

reg [WIDTH-1:0] shift_reg;
always @(posedge clk or posedge reset) begin
    if (reset) begin
        shift_reg <= {WIDTH{1'b0}};
    end else if (en) begin
        shift_reg <= {serial_in, shift_reg[WIDTH-1:1]};
    end
end

assign serial_out = shift_reg[0];

endmodule