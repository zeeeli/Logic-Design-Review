// NOTE:  The token price of a beverage is 5 cents,
// and our specially designed beverage vending machine
// only  accepts tokens of 1 cent, 2 cents and 5 cents.
// The task of the laboratory is to design a finite state machine
// for the automatic beverage vending machine. The following table
// shows the interface signals required for  this design.

// NOTE: Port Names | Port Direction | Port Size
//       -----------|----------------|----------
//          clk     | input          | 1 bit
//          reset   | input          | 1 bit
//          one     | input          | 1 bit
//          two     | input          | 1 bit
//          five    | input          | 1 bit
//          d       | output         | 1 bit
//          r       | output         | 3 bits

module vending_fsm (
    input  logic       clk,
    input  logic       reset,
    input  logic       one,
    input  logic       two,
    input  logic       five,
    output logic       d,
    output logic [2:0] r
);

  localparam S0 = 3'b000;
  localparam S1 = 3'b001;
  localparam S2 = 3'b010;
  localparam S3 = 3'b011;
  localparam S4 = 3'b100;
  localparam S5 = 3'b101;

  logic [2:0] state, next_state;
  logic [2:0] next_r;
  always_ff @(posedge clk or posedge reset) begin : state_transition
    if (reset) begin
      state <= S0;
      r     <= 0;
      d     <= 0;
    end else begin
      state <= next_state;
    end
  end

  always_comb begin : state_logic
    case (state)
      S0: begin
        r = 0;
        d = 0;
        if (one) begin
          next_state = S1;
        end else if (two) begin
          next_state = S2;
        end else if (five) begin
          next_state = S5;
          next_r = 0;
        end else begin
          next_state = S0;
        end
      end
      S1: begin
        if (one) begin
          next_state = S2;
        end else if (two) begin
          next_state = S3;
        end else if (five) begin
          next_state = S5;
          next_r = 1;
        end else begin
          next_state = S1;
        end

      end
      S2: begin
        if (one) begin
          next_state = S3;
        end else if (two) begin
          next_state = S4;
        end else if (five) begin
          next_state = S5;
          next_r = 2;
        end else begin
          next_state = S2;
        end

      end
      S3: begin
        if (one) begin
          next_state = S4;
        end else if (two) begin
          next_state = S5;
          next_r = 0;
        end else if (five) begin
          next_state = S5;
          next_r = 3;
        end else begin
          next_state = S3;
        end

      end
      S4: begin
        if (one) begin
          next_state = S5;
          next_r = 0;
        end else if (two) begin
          next_state = S5;
          next_r = 1;
        end else if (five) begin
          next_state = S5;
          next_r = 4;
        end else begin
          next_state = S4;
        end

      end
      S5: begin
        d = 1;
        r = next_r;
        if (one) begin
          next_state = S1;
        end else if (two) begin
          next_state = S2;
        end else if (five) begin
          next_state = S5;
        end else begin
          next_state = S0;
        end
      end
      default: next_state = S0;
    endcase
  end

endmodule
