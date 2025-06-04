module half_adder (
    input  logic a,
    input  logic b,
    output logic sum,
    output logic cout
);
  assign {cout, sum} = a + b;
endmodule
