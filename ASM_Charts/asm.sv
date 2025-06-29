module asm (
    input  logic       clk,
    input  logic       rst,
    input  logic       in,
    output logic [1:0] y,
    output logic       z
);
  parameter S0 = 2'b00;
  parameter S1 = 2'b01;
  parameter S2 = 2'b10;
  parameter S3 = 2'b11;

  logic [1:0] state, next_state;

  always_ff @(posedge clk or posedge rst) begin : state_trans
    if (rst) begin
      state <= S0;
      y <= '0;
      z <= '0;
    end else begin
      state <= next_state;
    end
  end

  always_comb begin : state_trans_logic
    case (state)
      S0: next_state = in ? S1 : S0;
      S1: next_state = in ? S1 : S2;
      S2: next_state = in ? S1 : S3;
      S3: next_state = S0;
      default: next_state = S0;
    endcase
  end

  // Output logic
  always_comb begin
    y = (state == S1);
    y = (state == S2 || state == S3);
    z = ((state == S1 && in) || (state == S2 && in));
  end

endmodule
