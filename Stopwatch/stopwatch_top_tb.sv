module stopwatch_top_tb;
  logic       clk;
  logic       rst;
  logic       start;
  logic       stop;
  logic [3:0] y2;
  logic [3:0] y1;
  logic [3:0] y0;

  stopwatch_top uut (
      .clk(clk),
      .rst(rst),
      .start(start),
      .stop(stop),
      .y2(y2),
      .y1(y1),
      .y0(y0)
  );

  initial begin
    $dumpfile("stopwatch_top.vcd");
    $dumpvars(0, stopwatch_top_tb);
  end

  always #1 clk = ~clk;

  initial begin
    rst   = 1;
    clk   = 0;
    start = 0;
    stop  = 0;
    #2;
    rst   = 0;
    start = 1;
    #800;
    start = 0;
    stop  = 1;
    #200;
    start = 1;
    stop  = 0;
    #200;
    rst   = 1;
    start = 0;
    #10;
    rst   = 0;
    start = 1;
    #20000;
    $finish;
  end








endmodule
