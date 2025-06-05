module bcd4 (
    input  logic       clk,
    input  logic       rst,
    output logic [3:0] out
);
  logic [3:0] cnt;

  always_ff @(posedge clk or posedge rst) begin : bcd
    if (rst) begin
      cnt <= '0;
    end else if (cnt == 4'h9) begin
      cnt <= '0;
    end else begin
      cnt <= cnt + 1;
    end
  end

  assign out = cnt;
endmodule
