module asm_tb;
  logic       clk;
  logic       rst;
  logic       in;
  logic [1:0] y;
  logic       z;

  asm uut (
      .clk(clk),
      .rst(rst),
      .in (in),
      .y  (y),
      .z  (z)
  );

  initial begin
    $dumpfile("asm.vcd");
    $dumpvars(0, asm_tb);
  end

  always #5 clk = ~clk;

  initial begin
    clk = 0;
    rst = 1;
    in  = 0;
    #10;
    rst = 0;
    in  = 0;
    #10;
    in = 1;
    #10;
    in = 1;
    #10;
    in = 0;
    #10;
    in = 1;
    #10;
    in = 0;
    #10;
    in = 0;
    #10;
    in = 1;
    $finish;
  end
endmodule
