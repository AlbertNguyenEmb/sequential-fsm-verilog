`timescale 1ns/1ps
module counter_mod10 (
    input wire clk,
    input wire reset,
    input wire en,
    output reg [3:0] count
);

always @(posedge clk) begin
    if (reset) begin
        count <= 4'b0000;
    end
    else begin
        if (en) begin
            if (count == 4'd9) begin
                count <= 4'd0;
            end
            else begin
                count <= count + 1'd1;
            end
        end
    end
    
end
    
endmodule