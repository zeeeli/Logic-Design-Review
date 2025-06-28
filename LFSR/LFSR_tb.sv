`define WIDTH 5
module LFSR_tb;

  logic clk;
  logic rst;
  logic [`WIDTH-1:0] q;

  LFSR #(`WIDTH) uut (
      .clk(clk),
      .rst(rst),
      .q  (q)
  );

  initial begin
    $dumpfile("LFSR.vcd");
    $dumpvars(0, LFSR_tb);
  end

  always #5 clk = ~clk;

  initial begin
    clk = 0;
    rst = 1;
    #10;
    rst = 0;
    #330;
    $finish;
  end
endmodule
