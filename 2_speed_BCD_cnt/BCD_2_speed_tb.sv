module BCD_2_speed_tb;
  logic       clk;
  logic       rst;
  logic       sel;
  logic [3:0] y;

  BCD_2_speed uut (
      .clk(clk),
      .rst(rst),
      .sel(sel),
      .y  (y)
  );

  // VCD dump
  initial begin
    $dumpfile("BCD_2_speed.vcd");
    $dumpvars(0, BCD_2_speed_tb);
  end

  initial begin
    clk = 0;
    sel = 0;
    rst = 1;
    #10;
    rst = 0;
    repeat (200) begin
      clk = ~clk;
      sel = $urandom_range(0, 1);
      #5;
    end
    $finish;
  end
endmodule
