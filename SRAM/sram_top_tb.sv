module sram_top_tb;

  parameter WIDTH = 4;
  parameter DEPTH = 32;
  parameter ADDR_WIDTH = $clog2(DEPTH);

  logic                  clk;
  logic                  rst;
  logic                  wr_req;
  logic                  re_req;
  logic [ADDR_WIDTH-1:0] addr_in;
  logic [     WIDTH-1:0] din_in;
  logic [     WIDTH-1:0] dout_out;

  // DUT
  sram_top #(WIDTH, DEPTH) uut (
      .clk(clk),
      .rst(rst),
      .wr_req(wr_req),
      .re_req(re_req),
      .addr_in(addr_in),
      .din_in(din_in),
      .dout_out(dout_out)
  );

  initial begin
    $dumpfile("sram_top.vcd");
    $dumpvars(0, sram_top_tb);
  end

  always #5 clk = ~clk;

  initial begin
    clk = 0;
    rst = 1;
    wr_req = 0;
    re_req = 0;
    addr_in = 0;
    din_in = 4'b1010;

    #12;
    rst = 0;

    // Write din_in into all 32 addresses
    for (int i = 0; i < DEPTH; i++) begin
      addr_in = i;
      din_in  = 4'b1010;
      wr_req  = 1;
      #10;
      wr_req = 0;
      #10;
    end

    // Now read back and verify
    for (int i = 0; i < DEPTH; i++) begin
      addr_in = i;
      re_req  = 1;
      #10;
      re_req = 0;

      #10;  // wait for FSM to complete read
      $display("Address %0d: Read = %b", i, dout_out);
    end
    $finish;
  end

endmodule
