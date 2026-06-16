module serial_adder_mealy #(
    parameter WIDTH = 4
)(
    input  wire             clk,
    input  wire             reset,
    input  wire             start,
    input  wire [WIDTH-1:0] a,
    input  wire [WIDTH-1:0] b,

    output reg  [WIDTH-1:0] sum,
    output reg              carry_out,
    output reg              serial_sum,
    output reg              busy,
    output reg              done
);

localparam IDLE = 2'b00;
localparam RUN  = 2'b01;
localparam DONE = 2'b10;

reg [1:0] state;

reg [WIDTH-1:0] a_shift;
reg [WIDTH-1:0] b_shift;
reg             carry;
reg [7:0]       count;

wire [1:0] bit_add;

assign bit_add = a_shift[0] + b_shift[0] + carry;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state      <= IDLE;
        a_shift    <= {WIDTH{1'b0}};
        b_shift    <= {WIDTH{1'b0}};
        sum        <= {WIDTH{1'b0}};
        carry      <= 1'b0;
        carry_out  <= 1'b0;
        serial_sum <= 1'b0;
        busy       <= 1'b0;
        done       <= 1'b0;
        count      <= 8'd0;
    end else begin
        case (state)

            IDLE: begin
                done       <= 1'b0;
                busy       <= 1'b0;
                serial_sum <= 1'b0;

                if (start) begin
                    a_shift   <= a;
                    b_shift   <= b;
                    sum       <= {WIDTH{1'b0}};
                    carry     <= 1'b0;
                    carry_out <= 1'b0;
                    count     <= 8'd0;
                    busy      <= 1'b1;
                    state     <= RUN;
                end
            end

            RUN: begin
                busy       <= 1'b1;
                serial_sum <= bit_add[0];
                sum[count] <= bit_add[0];
                carry      <= bit_add[1];

                a_shift <= {1'b0, a_shift[WIDTH-1:1]};
                b_shift <= {1'b0, b_shift[WIDTH-1:1]};

                if (count == WIDTH - 1) begin
                    carry_out <= bit_add[1];
                    done      <= 1'b1;
                    busy      <= 1'b0;
                    state     <= DONE;
                end else begin
                    count <= count + 1'b1;
                end
            end

            DONE: begin
                done <= 1'b1;
                busy <= 1'b0;

                if (!start) begin
                    state <= IDLE;
                end
            end

            default: begin
                state <= IDLE;
            end

        endcase
    end
end

endmodule