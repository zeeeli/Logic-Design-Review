module full_adder_tb;
  logic a;
  logic b;
  logic cin;
  logic cout;
  logic sum;

  full_adder uut (
      .a(a),
      .b(b),
      .cin(cin),
      .cout(cout),
      .sum(sum)
  );

  initial begin
    // Dump waveform
    $dumpfile("full_adder.vcd");
    $dumpvars(0, full_adder_tb);

    for (int i = 3'b000; i <= 3'b111; i++) begin
      a   = i[2];
      b   = i[1];
      cin = i[0];
      #10;
    end
  end
endmodule
