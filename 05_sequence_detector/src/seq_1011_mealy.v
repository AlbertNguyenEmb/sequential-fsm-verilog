module seq_1011_mealy(
    input wire clk,
    input wire reset,
    input wire bit_in,
    output reg detected
);

reg [1:0] state;
reg [1:0] next_state;

localparam S0 = 2'b00;
localparam S1 = 2'b01;
localparam S10 = 2'b10;
localparam S101 = 2'b11;

//1. State register
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= S0;
    end else begin
        state <= next_state;
    end
end
//2. Next state logic
always @(*) begin
    next_state = state;
    case (state)
        S0: begin
            if (bit_in) begin
                next_state <= S1;
            end else begin
                next_state <= S0;
            end
        end
        S1: begin
            if (bit_in) begin
                next_state <= S1;
            end else begin
                next_state <= S10;
            end
        end
        S10: begin
            if (bit_in) begin
                next_state <= S101;
            end else begin
                next_state <= S0;
            end
        end
        S101: begin
            if (bit_in)
                next_state = S1;   // overlap support
            else
                next_state = S10;
        end
        default: begin
            next_state = S0;
        end
    endcase
end

//Output logic for Mealy FSM
always @(*) begin
    detected = 1'b0;
    case (state)
        S101: begin
            if (bit_in)
                detected = 1'b1;
            else
                detected = 1'b0;
        end
        default: begin
            detected = 1'b0;
        end
    endcase
end
endmodule