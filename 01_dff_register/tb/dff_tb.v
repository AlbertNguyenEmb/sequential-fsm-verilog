//Testbench 
`timescale 1ns/1ps

module dff_tb;

reg clk;
reg d;
wire q;
reg en;
reg rst;

dff uut (
    .clk(clk),
    .d(d),
    .q(q),
    .en(en),
    .rst(rst)
);

// Tạo clock chu kỳ 10ns
always #5 clk = ~clk;

initial begin
    clk   = 0;
    rst = 1;
    en    = 0;
    d     = 0;

    // Giữ reset một lúc
    #12 rst = 0;

    // en = 0, d đổi nhưng q phải giữ nguyên
    #8  d = 1;
    #10 d = 0;
    #10 d = 1;

    // bật enable, q bắt đầu lấy d tại cạnh clock
    #5 en = 1;
    #10 d = 0;
    #10 d = 1;
    #10 d = 0;

    // tắt enable, q giữ nguyên
    #10 en = 0;
    #10 d = 1;
    #10 d = 0;

    // reset lại
    #10 rst = 1;
    #10 rst = 0;
    $stop;
end
endmodule