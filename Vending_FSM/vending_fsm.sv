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
  logic       next_d;

  // Sequential logic
  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= S0;
      r     <= 3'd0;
      d     <= 1'b0;
    end else begin
      state <= next_state;
      r     <= next_r;
      d     <= next_d;
    end
  end

  // Combinational logic
  always_comb begin
    next_state = state;
    next_r     = 3'd0;
    next_d     = 1'b0;

    case (state)
      S0: begin
        if (one) next_state = S1;
        else if (two) next_state = S2;
        else if (five) next_state = S5;
      end

      S1: begin
        if (one) next_state = S2;
        else if (two) next_state = S3;
        else if (five) begin
          next_state = S5;
          next_r = 3'd1;
        end
      end

      S2: begin
        if (one) next_state = S3;
        else if (two) next_state = S4;
        else if (five) begin
          next_state = S5;
          next_r = 3'd2;
        end
      end

      S3: begin
        if (one) next_state = S4;
        else if (two) begin
          next_state = S5;
          next_r = 3'd0;
        end else if (five) begin
          next_state = S5;
          next_r = 3'd3;
        end
      end

      S4: begin
        if (one) begin
          next_state = S5;
          next_r = 3'd0;
        end else if (two) begin
          next_state = S5;
          next_r = 3'd1;
        end else if (five) begin
          next_state = S5;
          next_r = 3'd4;
        end
      end

      S5: begin
        next_d = 1'b1;  // Dispense drink
        if (one) next_state = S1;
        else if (two) next_state = S2;
        else if (five) next_state = S5;
        else next_state = S0;
      end

      default: next_state = S0;
    endcase
  end

endmodule
