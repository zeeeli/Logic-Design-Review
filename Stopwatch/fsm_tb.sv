module fsm_tb;
  logic clk;
  logic rst;
  logic start;
  logic stop;
  logic en;

  fsm uut (
      .clk(clk),
      .rst(rst),
      .start(start),
      .stop(stop),
      .en(en)
  );

  initial begin
    $dumpfile("fsm.vcd");
    $dumpvars(0, fsm_tb);
  end

  always #1 clk = ~clk;

  initial begin
    clk   = 0;
    rst   = 1;
    start = 0;
    stop  = 0;
    #2;
    rst = 0;
    #5;
    start = 1;
    stop  = 0;
    #2;
    start = 0;
    stop  = 1;
    #2;
    start = 0;
    stop  = 0;
    #2;
    start = 1;
    stop  = 1;
    #2;
    start = 0;
    stop  = 0;
    $finish;
  end
endmodule
