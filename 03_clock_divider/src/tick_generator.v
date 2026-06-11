module tick_generator #(
    parameter MAX_COUNT = 10
)(
    input  wire clk,
    input  wire reset,
    output reg  tick
);

reg [31:0] count;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        count <= 32'd0;
        tick  <= 1'b0;
    end else begin
        if (count == MAX_COUNT - 1) begin
            count <= 32'd0;
            tick  <= 1'b1;
        end else begin
            count <= count + 1'b1;
            tick  <= 1'b0;
        end
    end
end

endmodule