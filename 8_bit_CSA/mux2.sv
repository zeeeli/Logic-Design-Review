module mux2 (
    input  logic [1:0] d,
    input  logic       s,
    output logic       y
);

  assign y = s ? d[1] : d[0];

  // always_comb begin : mux
  //   if (s) begin
  //     y = d[1];
  //   end else begin
  //     y = d[0];
  //   end
  // end
endmodule
