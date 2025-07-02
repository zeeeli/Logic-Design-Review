module sram_top #(
    parameter WIDTH = 4,
    parameter DEPTH = 32
) (
    input  logic                     clk,      // clock
    input  logic                     rst,      // reset
    input  logic                     wr_req,   // write request
    input  logic                     re_req,   // read request
    input  logic [$clog2(DEPTH)-1:0] addr_in,  // external address input
    input  logic [        WIDTH-1:0] din_in,   // external data input
    output logic [        WIDTH-1:0] dout_out  // ram data output
);

  // Internal registers
  logic cs, we, oe;

  // RAM Output
  logic [WIDTH-1:0] ram_dout;

  mem_fsm #(
      .WIDTH(WIDTH),
      .DEPTH(DEPTH)
  ) fsm (
      .clk   (clk),
      .rst   (rst),
      .wr_req(wr_req),
      .re_req(re_req),
      .we    (we),
      .cs    (cs),
      .oe    (oe)
  );

  ram #(
      .WIDTH(WIDTH),
      .DEPTH(DEPTH)
  ) ram_i (
      .clk (clk),
      .we  (we),
      .cs  (cs),
      .oe  (oe),
      .addr(addr_in),
      .din (din_in),
      .dout(ram_dout)
  );

  assign dout_out = ram_dout;
endmodule
