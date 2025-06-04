// 3 X 3 Binary Combinationl Multiplier
module comb_multi_33 (
    input  logic [2:0] x,
    input  logic [2:0] y,
    output logic [5:0] p
);
  // Internal Registers
  logic ha1_cout, fa1_cout, ha2_cout, ha3_cout, fa2_cout;
  logic fa1_sum, ha2_sum;

  assign p[0] = x[0] & y[0];
  half_adder ha1 (
      .a(x[0] & y[1]),
      .b(x[1] & y[0]),
      .sum(p[1]),
      .cout(ha1_cout)
  );
  full_adder fa1 (
      .a(x[1] & y[1]),
      .b(x[2] & y[0]),
      .cin(ha1_cout),
      .cout(fa1_cout),
      .sum(fa1_sum)
  );
  half_adder ha2 (
      .a(x[2] & y[1]),
      .b(fa1_cout),
      .sum(ha2_sum),
      .cout(ha2_cout)
  );
  half_adder ha3 (
      .a(x[0] & y[2]),
      .b(fa1_sum),
      .sum(p[2]),
      .cout(ha3_cout)
  );
  full_adder fa2 (
      .a(x[1] & y[2]),
      .b(ha2_sum),
      .cin(ha3_cout),
      .cout(fa2_cout),
      .sum(p[3])
  );
  full_adder fa4 (
      .a(x[2] & y[2]),
      .b(ha2_cout),
      .cin(fa2_cout),
      .cout(p[5]),
      .sum(p[4])
  );
endmodule
