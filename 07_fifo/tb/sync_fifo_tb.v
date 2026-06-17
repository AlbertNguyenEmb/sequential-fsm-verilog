`timescale 1ns/1ps

module sync_fifo_tb;

reg clk;
reg reset;

reg wr_en;
reg rd_en;
reg [7:0] data_in;

wire [7:0] data_out;
wire full;
wire empty;
wire [3:0] count;

sync_fifo #(
    .DATA_WIDTH(8),
    .DEPTH(8),
    .ADDR_WIDTH(3)
) uut (
    .clk(clk),
    .reset(reset),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .data_in(data_in),
    .data_out(data_out),
    .full(full),
    .empty(empty),
    .count(count)
);

always #5 clk = ~clk;

task write_fifo;
    input [7:0] data;
    begin
        @(negedge clk);
        data_in = data;
        wr_en = 1'b1;
        rd_en = 1'b0;

        @(negedge clk);
        wr_en = 1'b0;
        data_in = 8'h00;
    end
endtask

task read_fifo;
    input [7:0] expected;
    begin
        @(negedge clk);
        rd_en = 1'b1;
        wr_en = 1'b0;

        @(negedge clk);
        rd_en = 1'b0;

        #1;
        if (data_out == expected) begin
            $display("PASS: read %h", data_out);
        end else begin
            $display("FAIL: read %h, expected %h", data_out, expected);
        end
    end
endtask

initial begin
    clk = 0;
    reset = 1;
    wr_en = 0;
    rd_en = 0;
    data_in = 8'h00;

    #12 reset = 0;

    $display("Test 1: Write 3 data");
    write_fifo(8'hA1);
    write_fifo(8'hB2);
    write_fifo(8'hC3);

    $display("Test 2: Read 3 data in FIFO order");
    read_fifo(8'hA1);
    read_fifo(8'hB2);
    read_fifo(8'hC3);

    $display("Test 3: Fill FIFO");
    write_fifo(8'h11);
    write_fifo(8'h22);
    write_fifo(8'h33);
    write_fifo(8'h44);
    write_fifo(8'h55);
    write_fifo(8'h66);
    write_fifo(8'h77);
    write_fifo(8'h88);

    if (full)
        $display("PASS: FIFO is full");
    else
        $display("FAIL: FIFO should be full");

    $display("Test 4: Try writing when full");
    write_fifo(8'h99);

    $display("Test 5: Read all data");
    read_fifo(8'h11);
    read_fifo(8'h22);
    read_fifo(8'h33);
    read_fifo(8'h44);
    read_fifo(8'h55);
    read_fifo(8'h66);
    read_fifo(8'h77);
    read_fifo(8'h88);

    if (empty)
        $display("PASS: FIFO is empty");
    else
        $display("FAIL: FIFO should be empty");

    $display("Test 6: Try reading when empty");
    @(negedge clk);
    rd_en = 1'b1;
    @(negedge clk);
    rd_en = 1'b0;

    #30;
    $finish;
end

endmodule