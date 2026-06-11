`timescale 1ns/1ps
module led_blink_tick_tb ();
reg clk;
reg reset;
wire led;

led_blink_tick uut (
    .clk(clk),
    .reset(reset),
    .led(led)
);
always #5 clk = ~clk;
initial begin
    clk = 0;
    reset = 1;
    #10
    reset = 0;
    #200
        reset = 1;
    #10;
    reset = 0;

    #100;

    $stop;
end
endmodule