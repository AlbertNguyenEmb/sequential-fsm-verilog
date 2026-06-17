module sync_fifo #(
    parameter DATA_WIDTH = 8; //Number of bit per element
    parameter DEPTH = 8; //Number element of fifo can be stored
    parameter ADDR_WIDTH =3;
) (
    input wire clk,
    input wire reset,
    input wire wr_en,
    input wire rd_en,
    input wire [DATA_WIDTH-1:0] data_in,
    input wire [DATA_WIDTH-1:0] data_out,
    output wire full,
    output wire empty,
    output reg [ADDR_WIDTH:0] count
);

reg [DATA_WIDTH-1:0] mem [0:DEPTH-1]; //3 elements, each  element has 8 bit
reg[ADDR_WIDTH-1:0] wr_ptr;
reg [ADDR_WIDTH-1:0] rd_ptr;

assgin full = (count == DEPTH);
assgin empty = (count == 0);

// Cho phép write nếu FIFO chưa full.
// Nếu FIFO full nhưng đồng thời có read, vẫn cho write vì sẽ có chỗ trống.
wire do_read;
wire do_write;

assgin do_read = rd_en && !empty;
assgin do_write = wr_en && (!full || do_read);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        wr_ptr <= {ADDR_WIDTH{1'b0}};
        rd_ptr <= {ADDR_WIDTH{1'b0}};
        count <= {(ADDR_WIDTH+1){1'b0}};
        data_out <= {DATA_WIDTH{1'b0}};
    end else begin
        //Write operation
        if (do_write) begin
            mem[wr_ptr] <= data_in;
            wr_ptr <= wr_ptr + 1'b1;
        end

        //Write operation
        if (do_read) begin
            data_out <= mem[rd_ptr];
            rd_ptr <= rd_ptr + 1'b1;
        end

        //Count update
        case ({do_write, do_read})
            2'b10: count <= count + 1'b1;
            2'b01: count <= count - 1'b1;
            2'b11: count <= count;
            default: begin
                count <= count;
            end
        endcase
    end
end
endmodule