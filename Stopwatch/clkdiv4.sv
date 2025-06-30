module clkdiv4 (
    input  logic clk,
    input  logic rst,
    output logic clk2
);
  logic [1:0] cnt = '0;

  always_ff @(posedge clk or posedge rst) begin : clock_divider
    if (rst) begin
      clk2 <= 0;
      cnt  <= 0;
    end else begin
      cnt <= cnt + 1;
      if (cnt == 3) begin
        clk2 <= ~clk2;
      end
    end
  end
endmodule
