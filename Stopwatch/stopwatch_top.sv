`include "../Stopwatch/clkdiv4.sv"
`include "../Stopwatch/fsm.sv"
`include "../Stopwatch/watch.sv"

module stopwatch_top (
    input  logic       clk,
    input  logic       rst,
    input  logic       start,
    input  logic       stop,
    output logic [3:0] y2,
    output logic [3:0] y1,
    output logic [3:0] y0

);
  // Internal Registers
  logic clk2;
  logic en;

  // Module Instantiation
  clkdiv4 g1 (
      .clk (clk),
      .rst (rst),
      .clk2(clk2)
  );

  fsm g2 (
      .clk(clk2),
      .rst(rst),
      .start(start),
      .stop(stop),
      .en(en)
  );

  watch g3 (
      .clk(clk2),
      .rst(rst),
      .en (en),
      .y2 (y2),
      .y1 (y1),
      .y0 (y0)
  );

endmodule
