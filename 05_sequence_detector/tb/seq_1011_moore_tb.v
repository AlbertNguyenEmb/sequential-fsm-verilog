`timescale 1ns/1ps

module seq_1011_moore_tb;

reg clk;
reg reset;
reg bit_in;
wire detected;

seq_1011_moore uut (
    .clk(clk),
    .reset(reset),
    .bit_in(bit_in),
    .detected(detected)
);

always #5 clk = ~clk;

task send_bit;
    input b;
    begin
        bit_in = b;
        #10;
    end
endtask

initial begin
    clk = 0;
    reset = 1;
    bit_in = 0;

    #12 reset = 0;

    // Test 1: input = 1011
    send_bit(1);
    send_bit(0);
    send_bit(1);
    send_bit(1);

    // nghỉ một chút
    send_bit(0);
    send_bit(0);

    // Test 2: overlap input = 1011011
    send_bit(1);
    send_bit(0);
    send_bit(1);
    send_bit(1);
    send_bit(0);
    send_bit(1);
    send_bit(1);

    #30 $finish;
end

endmodule