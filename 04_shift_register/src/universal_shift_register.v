`timescale 1ns/1ps
module universal_shift_register #(
    parameter WIDTH = 4
)(
    input wire clk,
    input wire reset,
    input wire [1:0] mode,
    input  wire             serial_in_left,
    input  wire             serial_in_right,
    input  wire [WIDTH-1:0] parallel_in,
    output reg  [WIDTH-1:0] parallel_out,
    output wire             serial_out_left,
    output wire             serial_out_right
);
// mode encoding
// 00: HOLD
// 01: SHIFT RIGHT
// 10: SHIFT LEFT
// 11: PARALLEL LOAD

always @(posedge clk or posedge reset) begin
    if (reset) begin
        parallel_out <= {WIDTH{1'b0}};
    end else begin
        case (mode)
            2'b00: parallel_out <= parallel_out;
            2'b01: begin
                parallel_out <= {serial_in_right, parallel_out[WIDTH-1:1]};
            end
            2'b10: begin
                parallel_out <= {parallel_out[WIDTH-2:0], serial_in_left};
            end
            2'b11: begin
                parallel_out <= parallel_in;
            end
            default: begin
                parallel_out <= parallel_out;
            end
        endcase
    end
end
assign serial_out_left = parallel_out[WIDTH-1];
assign serial_out_right = parallel_out[0];
endmodule