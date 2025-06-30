module watch_tb;
  logic clk;
  logic rst;
  logic en;
  logic [3:0] y2;
  logic [3:0] y1;
  logic [3:0] y0;

  watch uut (
      .clk(clk),
      .rst(rst),
      .en (en),
      .y2 (y2),
      .y1 (y1),
      .y0 (y0)
  );

  initial begin
    $dumpfile("watch.vcd");
    $dumpvars(0, watch_tb);
  end

  always #1 clk = ~clk;

  initial begin
    clk = 0;
    rst = 1;
    en  = 0;
    #2;
    rst = 0;
    en  = 1;
    #500;
    en = 0;
    #500;
    en = 1;
    #4000;
    $finish;
  end
endmodule
