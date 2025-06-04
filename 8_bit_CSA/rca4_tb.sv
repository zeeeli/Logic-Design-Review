module rca4_tb;
  logic [3:0] a;
  logic [3:0] b;
  logic       cin;
  logic       cout;
  logic [3:0] sum;

  rca4 uut (
      .a(a),
      .b(b),
      .cin(cin),
      .cout(cout),
      .sum(sum)
  );

  initial begin
    $dumpfile("rca4.vcd");
    $dumpvars(0, rca4_tb);
    $display("a   b   cin | cout sum");
    $display("------------------------");
    for (int i = 0; i < 2 ** $size(a); i++) begin
      for (int j = 0; j < 2 ** $size(b); j++) begin
        a   = i;
        b   = j;
        cin = 0;
        #5;
        cin = 1;
        #10;
        $display("%0d   %0d   %0d | %0d   %0d", a, b, cin, cout, sum);
      end
    end
    $finish;
  end

endmodule
