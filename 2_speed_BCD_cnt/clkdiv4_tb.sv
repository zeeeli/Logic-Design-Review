module clkdiv4_tb;
  logic clk1;
  logic rst;
  logic clk2;

  clkdiv4 uut (
      .clk1(clk1),
      .rst (rst),
      .clk2(clk2)
  );

  // VCD dump
  initial begin
    $dumpfile("clkdiv4.vcd");
    $dumpvars(0, clkdiv4_tb);
  end

  initial begin
    clk1 = 0;
    rst  = 1;
    #10;
    rst = 0;
    repeat (50) begin
      clk1 = ~clk1;
      #5;
    end
    $finish;
  end
endmodule
