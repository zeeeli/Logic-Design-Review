module full_adder (
    input  logic a,
    input  logic b,
    input  logic cin,
    output logic cout,
    output logic sum
);
  logic ha1_sum, ha1_cout, ha2_cout;

  half_adder ha1 (
      .a(a),
      .b(b),
      .sum(ha1_sum),
      .cout(ha1_cout)
  );
  half_adder ha2 (
      .a(cin),
      .b(ha1_sum),
      .sum(sum),
      .cout(ha2_cout)
  );

  assign cout = ha2_cout | ha1_cout;
endmodule
