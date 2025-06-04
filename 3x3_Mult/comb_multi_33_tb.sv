module comb_multi_33_tb;
  logic [2:0] x;
  logic [2:0] y;
  logic [5:0] p;

  comb_multi_33 uut (
      .x(x),
      .y(y),
      .p(p)
  );

  initial begin
    // Dump waveform
    $dumpfile("comb_multi_33.vcd");
    $dumpvars(0, comb_multi_33_tb);
    $display("x  y  | p (x*y)");
    $display("---------------");
    for (int i = 0; i < 8; i++) begin
      for (int j = 0; j < 8; j++) begin
        x = i;
        y = j;
        #5;
        $display("%0d  %0d  | %0d", x, y, p);
      end
    end
    $finish;
  end
endmodule
