// NOTE: FSM controls the start stop states of stopwatch
module fsm (
    input  logic clk,
    input  logic rst,
    input  logic start,
    input  logic stop,
    output logic en
);
  localparam IDLE = 2'b00;
  localparam RUN = 2'b01;
  localparam PAUSE = 2'b10;

  logic [1:0] state, next_state;

  always_ff @(posedge clk or posedge rst) begin : state_transition
    if (rst) begin
      state <= IDLE;
    end else begin
      state <= next_state;
    end
  end

  always_comb begin
    case (state)
      IDLE: begin
        if (start && ~stop) next_state = RUN;
        else next_state = IDLE;
      end

      RUN: begin
        if (stop && ~start) next_state = PAUSE;
        else next_state = RUN;
      end

      PAUSE: begin
        if (start && ~stop) next_state = RUN;
        else next_state = PAUSE;
      end

      default: next_state = IDLE;
    endcase
  end

  // Output logic
  assign en = (state == RUN);
endmodule
