`include "../8_bit_CSA/mux2.sv"
`include "../8_bit_CSA/muxb.sv"
`include "../8_bit_CSA/rca4.sv"

module csa8 (
    input  logic [7:0] a,
    input  logic [7:0] b,
    input  logic       cin,
    output logic       cout,
    output logic [7:0] sum
);

  // Internal Registers
  logic a1_cout, cout_mux_d0, cout_mux_d1;
  logic [3:0] sa;
  logic [3:0] sb;


  // Ripple carry adder for lower 4 sum bits
  rca4 a1 (
      .a(a[3:0]),
      .b(b[3:0]),
      .cin(cin),
      .cout(a1_cout),
      .sum(sum[3:0])
  );

  // Ripple carry adder for higher 4 bits when cin is 0
  rca4 a2 (
      .a(a[7:4]),
      .b(b[7:4]),
      .cin(0),
      .cout(cout_mux_d0),
      .sum(sa)
  );

  // Ripple carry adder for higher 4 bits when cin is 1
  rca4 a3 (
      .a(a[7:4]),
      .b(b[7:4]),
      .cin(1),
      .cout(cout_mux_d1),
      .sum(sb)
  );

  // 2-1 Mux to handle cout
  mux2 cout_mux (
      .d({cout_mux_d1, cout_mux_d0}),
      .s(a1_cout),
      .y(cout)
  );

  // 2-1 4 bit i/o mux to handle upper 4 sum bits
  muxb sum_hi_4 (
      .d0(sa),
      .d1(sb),
      .s (a1_cout),
      .y (sum[7:4])
  );
endmodule

