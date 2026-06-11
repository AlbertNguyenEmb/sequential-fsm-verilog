`timescale 1ns/1ps
module led_blink_tick #(
    parameter MAX_COUNT = 10
)(
    input wire clk,
    input wire reset,
    output reg led   
);

wire tick;
tick_generator #(
    .MAX_COUNT(MAX_COUNT)
) u_tick_generator (
    .clk(clk),
    .reset(reset),
    .tick(tick)
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        led <= 1'b0;
    end
    else if (tick) begin
        led <= ~led;
    end
end
endmodule