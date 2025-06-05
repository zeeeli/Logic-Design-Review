module csa8_tb;
  logic [7:0] a;
  logic [7:0] b;
  logic       cin;
  logic       cout;
  logic [7:0] sum;

  csa8 uut (
      .a(a),
      .b(b),
      .cin(cin),
      .cout(cout),
      .sum(sum)
  );

  // VCD dump
  initial begin
    $dumpfile("csa8.vcd");
    $dumpvars(0, csa8_tb);
  end


  initial begin
    $display("    a    b    cin |    sum    cout");
    $display("-----------------------------------");
    for (int i = 0; i < 500; i++) begin
      a   = $urandom;
      b   = $urandom;
      cin = $urandom_range(0, 1);
      #10;
      $display("    %0d    %0d    %0d |    %0d    %0d", a, b, cin, cout, sum);

      // TODO: Functional Coverage
      // ......
      //
    end
    $display("Random Test Complete");
    $finish;
  end
endmodule
