module pipo_register #(
    parameter WIDTH = 4
)(
    input  wire             clk,
    input  wire             reset,
    input  wire             load,
    input  wire [WIDTH-1:0] parallel_in,
    output reg  [WIDTH-1:0] parallel_out
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        parallel_out <= {WIDTH{1'b0}};
    end else if (load) begin
        parallel_out <= parallel_in;
    end
end

endmodule