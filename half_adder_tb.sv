module half_adder_tb;
  logic a;
  logic b;
  logic sum;
  logic cout;

  half_adder uut (
      .a(a),
      .b(b),
      .sum(sum),
      .cout(cout)
  );

  initial begin
    // Dump waveform
    $dumpfile("half_adder.vcd");
    $dumpvars(0, half_adder_tb);

    a = 0;
    b = 0;
    #10;
    a = 0;
    b = 1;
    #10;
    a = 1;
    b = 0;
    #10;
    a = 1;
    b = 1;
  end
endmodule
