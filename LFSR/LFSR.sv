module LFSR #(
    parameter WIDTH = 5,
    parameter SEED  = 1
) (
    input  logic             clk,
    input  logic             rst,
    output logic [WIDTH-1:0] q
);
  localparam [WIDTH-1:0] TAPS = 5'b10010;

  logic feedback;  // feedback bit for q[0]
  assign feedback = ^(q & TAPS);

  always_ff @(posedge clk or posedge rst) begin : lfsr
    if (rst) begin
      q <= SEED;
    end else begin
      q <= {q[WIDTH-2:0], feedback};  // shift left 1 and introduce feedback
    end
  end

endmodule
