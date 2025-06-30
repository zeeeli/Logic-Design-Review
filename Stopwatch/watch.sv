module watch (
    input  logic       clk,
    input  logic       rst,
    input  logic       en,
    output logic [3:0] y2,
    output logic [3:0] y1,
    output logic [3:0] y0
);

  logic [3:0] cnt2;
  logic [3:0] cnt1;
  logic [3:0] cnt0;

  always_ff @(posedge clk or posedge rst) begin : counter
    if (rst) begin
      cnt0 <= '0;  // Ones
      cnt1 <= '0;  // Tens
      cnt2 <= '0;  // Hundreds
    end else if (en) begin
      if (cnt0 != 9) cnt0 <= cnt0 + 1;
      else if (cnt0 == 9 && cnt1 != 9) begin
        cnt1 <= cnt1 + 1;
        cnt0 <= 0;
      end else if (cnt0 == 9 && cnt1 == 9 && cnt2 != 9) begin
        cnt2 <= cnt2 + 1;
        cnt1 <= 0;
        cnt0 <= 0;
      end else begin
        cnt0 <= '0;
        cnt1 <= '0;
        cnt2 <= '0;
      end
    end
  end

  assign y2 = cnt2;
  assign y1 = cnt1;
  assign y0 = cnt0;
endmodule
