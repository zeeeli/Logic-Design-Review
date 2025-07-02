module ram #(
  parameter WIDTH = 4,
  parameter DEPTH = 32
)(
    input  logic                     clk,    // clock
    input  logic                     we,     // write enable
    input  logic                     cs,     // chip select
    input  logic                     oe,     // output enable
    input  logic [$clog2(DEPTH)-1:0] addr,   // log2(DEPTH)-bit address (DEPTH locations)
    input  logic [      WIDTH-1:0]   din,    // WIDTH-bit data input
    output logic [      WIDTH-1:0]   dout    // WIDTH-bit data output
);

  // Memory array, DEPTH locations, each WIDTH bits wide
  logic [WIDTH-1:0] mem[0:DEPTH-1];

  // Synchronous write
  always_ff @(posedge clk) begin : write
    if (cs && we)
      mem[addr] <= din;
  end

  // Synchronous read (For targeting FPGAs)
  always_ff @(posedge clk) begin : read
    if (cs && oe && !we)
      dout <= mem[addr];
    // else: keep revious value
  end

  // // Asynchronous read
  // always_comb begin
  //   if (cs && oe && !we)
  //     dout = mem[addr];
  //   else
  //     // dout = '0;   
  //     dout = 'z;  // tri-state for sim only 
  // end
endmodule
