module seq_1011_moore(
    input wire clk,
    input wire reset,
    input wire bit_in,
    output reg detected
);

reg [2:0] state;
reg [2:0] next_state;

localparam S0 = 3'b000;
localparam S1 = 3'b001;
localparam S10 = 3'b010;
localparam S101 = 3'b011;
localparam S_DETECT = 3'b100;

//1.State register 
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= S0;
    end else begin
        state <= next_state;
    end
end
//2. Next-state logic
always @(*) begin
    next_state = state;
    case (state)
        S0: begin
            if (bit_in)
                next_state <= S1;
            else
                next_state <= S0;
        end
        S1: begin
            if (bit_in)
                next_state <= S1;
            else
                next_state <= S10;
        end
        S10: begin
            if (bit_in)
                next_state <= S101;
            else
                next_state <= S0;
        end
        S101: begin
            if (bit_in)
                next_state <= S_DETECT;
            else
                next_state <= S10;
        end
        S_DETECT: begin
            if (bit_in)
                next_state = S1;
            else
                next_state = S10;
        end
        default: begin
            next_state = S0;
        end
    endcase
end
//3. Output logic for Moore FSM
always @(*) begin
    if (state == S_DETECT) begin
        detected = 1'b1;
    end else begin
        detected = 1'b0;
    end
end
endmodule