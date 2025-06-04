// NOTE: 2-to-1 MUX with 4 bit inputs and 4 bit output and 1 bit select
module muxb (
    input  logic [3:0] d0,
    input  logic [3:0] d1,
    input  logic       s,
    output logic [3:0] y
);

  assign y = s ? d1 : d0;

endmodule
