module piso_shift_register #(
    parameter WIDTH = 4
)(
    input wire clk,
    input wire reset,
    input wire load,
    input wire shift_en,
    input wire serial_in,
    input  wire [WIDTH-1:0] parallel_in,
    output wire             serial_out
);

reg [WIDTH-1:0] shift_reg;
always @(posedge clk or posedge reset) begin
    if (reset) begin
        shift_reg <= {WIDTH{1'b0}};
    end else if (load) begin
        shift_reg <= parallel_in;
    end else if (shift_en) begin
        shift_reg <= {serial_in, shift_reg[WIDTH-1:1]};
    end
end

    assign serial_out = shift_reg[0];
endmodule