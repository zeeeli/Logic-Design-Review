module mux2_tb;
  logic [1:0] d;
  logic       s;
  logic       y;

  mux2 uut (
      .d(d),
      .s(s),
      .y(y)
  );

  initial begin
    $dumpfile("mux2.vcd");
    $dumpvars(0, mux2_tb);
    $display("d[1]  d[0]  sel |  y");
    $display("---------------------");
    for (int i = 0; i < 2 ** 3; i++) begin
      {d[1], d[0], s} = i[2:0];
      #5;
      $display("%0d  %0d  %0d |  %0d", d[1], d[0], s, y);
    end
  end
endmodule
