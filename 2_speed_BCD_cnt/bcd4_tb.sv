module bcd4_tb;
  logic       clk;
  logic       rst;
  logic [3:0] out;

  bcd4 uut (
      .clk(clk),
      .rst(rst),
      .out(out)
  );

  // VCD dump
  initial begin
    $dumpfile("bcd4.vcd");
    $dumpvars(0, bcd4_tb);
  end

  initial begin
    clk = 0;
    rst = 1;
    #10;
    rst = 0;
    repeat (50) begin
      clk = ~clk;
      #5;
    end
    $finish;
  end
endmodule
