module muxb_tb;
  logic [3:0] d0;
  logic [3:0] d1;
  logic       s;
  logic [3:0] y;

  muxb uut (
      .d0(d0),
      .d1(d1),
      .s (s),
      .y (y)
  );

  initial begin
    $dumpfile("muxb.vcd");
    $dumpvars(0, muxb_tb);
    $display("    d0    d1    sel |    y");
    $display("---------------------");
    for (int i = 0; i < 2 ** 3; i++) begin
      d0 = i;
      d1 = ~i[3:0];
      s  = 0;
      #5;
      $display("%0d  %0d  %0d |  %0d", d0, d1, s, y);

      s = 1;
      #5;
      $display("%0d  %0d  %0d |  %0d", d0, d1, s, y);
    end
  end
endmodule
