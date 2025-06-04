`include "../3x3_Mult/half_adder.sv"
`include "../3x3_Mult/full_adder.sv"

module rca4 (
    input  logic [3:0] a,
    input  logic [3:0] b,
    input  logic       cin,
    output logic       cout,
    output logic [3:0] sum
);

  logic fa1_out, fa2_out, fa3_out;

  full_adder fa1 (
      .a(a[0]),
      .b(b[0]),
      .cin(cin),
      .cout(fa1_out),
      .sum(sum[0])
  );
  full_adder fa2 (
      .a(a[1]),
      .b(b[1]),
      .cin(fa1_out),
      .cout(fa2_out),
      .sum(sum[1])
  );
  full_adder fa3 (
      .a(a[2]),
      .b(b[2]),
      .cin(fa2_out),
      .cout(fa3_out),
      .sum(sum[2])
  );
  full_adder fa4 (
      .a(a[3]),
      .b(b[3]),
      .cin(fa3_out),
      .cout(cout),
      .sum(sum[3])
  );
endmodule
