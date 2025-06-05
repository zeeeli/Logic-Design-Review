module clkdiv4 (
    input  logic clk1,
    input  logic rst,
    output logic clk2
);
  logic [1:0] cnt;

  always_ff @(posedge clk1 or posedge rst) begin : clk_div
    if (rst) begin
      cnt  <= '0;
      clk2 <= 0;
    end else begin
      cnt <= cnt + 1;
      if (cnt == 3) begin
        clk2 <= ~clk2;
      end
    end
  end
endmodule
