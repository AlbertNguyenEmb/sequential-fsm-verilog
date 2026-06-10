`timescale 1ns/1ps
module counter_up_down_4bit (
    input wire clk,
    input wire reset,
    input wire en,
    input wire dir,
    output reg [3:0] count
);

always @(posedge clk) begin
    if (reset) begin
        count = 4'b0;
    end else if (en) begin
        if (dir) begin
            count <= count + 1'b1;
        end else begin
            count <= count - 1'b1;
        end
    end
end
endmodule