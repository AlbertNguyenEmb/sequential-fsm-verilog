`timescale 1ns/1ps

module serial_adder_mealy_tb;

reg clk;
reg reset;
reg start;
reg [3:0] a;
reg [3:0] b;

wire [3:0] sum;
wire carry_out;
wire serial_sum;
wire busy;
wire done;

serial_adder_mealy #(
    .WIDTH(4)
) uut (
    .clk(clk),
    .reset(reset),
    .start(start),
    .a(a),
    .b(b),
    .sum(sum),
    .carry_out(carry_out),
    .serial_sum(serial_sum),
    .busy(busy),
    .done(done)
);

always #5 clk = ~clk;

task run_test;
    input [3:0] ta;
    input [3:0] tb;
    reg [4:0] expected;
    begin
        expected = ta + tb;

        a = ta;
        b = tb;

        start = 1'b1;
        #10;
        start = 1'b0;

        wait(done == 1'b1);
        #1;

        if ({carry_out, sum} == expected) begin
            $display("PASS: %b + %b = %b", ta, tb, {carry_out, sum});
        end else begin
            $display("FAIL: %b + %b = %b, expected %b",
                     ta, tb, {carry_out, sum}, expected);
        end

        #20;
    end
endtask

initial begin
    clk = 0;
    reset = 1;
    start = 0;
    a = 4'b0000;
    b = 4'b0000;

    #12 reset = 0;

    run_test(4'b0011, 4'b0101); // 3 + 5 = 8
    run_test(4'b1011, 4'b0110); // 11 + 6 = 17
    run_test(4'b1111, 4'b0001); // 15 + 1 = 16
    run_test(4'b1001, 4'b0101); // 9 + 5 = 14

    #30 $finish;
end

endmodule