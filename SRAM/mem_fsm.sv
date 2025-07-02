module mem_fsm #(
    parameter WIDTH = 4,
    parameter DEPTH = 32
) (
    input  logic clk,
    input  logic rst,
    input  logic wr_req,  // write request flag
    input  logic re_req,  // read request flag
    output logic we,      // write enable control signal
    output logic cs,      // chip select control signal
    output logic oe       // output enable (read) control signal

);

  localparam IDLE = 2'b00;
  localparam WRITE = 2'b01;
  localparam READ = 2'b10;

  logic [1:0] state, next_state;

  always_ff @(posedge clk or posedge rst) begin : state_transition
    if (rst) begin
      state <= IDLE;
    end else begin
      state <= next_state;
    end
  end

  always_comb begin : state_logic
    case (state)
      IDLE: begin
        if (wr_req) next_state = WRITE;
        else if (re_req) next_state = READ;
        else next_state = IDLE;
      end
      WRITE: next_state = IDLE;
      READ: next_state = IDLE;
      default: next_state = IDLE;
    endcase
  end

  // output logic
  always_comb begin : output_logic
    cs = 0;
    we = 0;
    oe = 0;
    case (state)
      WRITE: begin
        cs = 1;
        we = 1;
      end
      READ: begin
        cs = 1;
        oe = 1;
      end
      default: ;
    endcase
  end
endmodule
