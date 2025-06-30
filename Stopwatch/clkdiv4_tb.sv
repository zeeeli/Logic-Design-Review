module clkdiv4_tb;
  logic clk;
  logic rst;
  logic clk2;

  clkdiv4 uut (
      .clk (clk),
      .rst (rst),
      .clk2(clk2)
  );

  initial begin
    $dumpfile("clkdiv4.vcd");
    $dumpvars(0, clkdiv4_tb);
  end

  always #5 clk = ~clk;

  initial begin
    clk = 0;
    rst = 1;
    #10;
    rst = 0;
    #175;
    $finish;
  end
endmodule
