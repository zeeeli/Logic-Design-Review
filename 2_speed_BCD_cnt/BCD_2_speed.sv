`include "../8_bit_CSA/mux2.sv"
`include "../2_speed_BCD_cnt/bcd4.sv"
`include "../2_speed_BCD_cnt/clkdiv4.sv"

module BCD_2_speed (
    input  logic       clk,
    input  logic       rst,
    input  logic       sel,
    output logic [3:0] y
);

  // Internal Registers
  logic clk_div_4;
  logic clk_y;

  clkdiv4 g1 (
      .clk1(clk),
      .rst (rst),
      .clk2(clk_div_4)
  );

  mux2 g2 (
      .d({clk_div_4, clk}),
      .s(sel),
      .y(clk_y)
  );

  bcd4 g3 (
      .clk(clk_y),
      .rst(rst),
      .out(y)
  );
endmodule
