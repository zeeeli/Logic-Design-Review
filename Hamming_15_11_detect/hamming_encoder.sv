// NOTE: In Big-Endian data_out
// => 15  14  13  12  11 10 9  8  7  6  5  4  3  2  1  0
// => d10 d9  d8  d7  d6 d5 d4 p4 d3 d2 d1 p3 d0 p2 p1 p0 -> p0 = whole block parity
module hamming_encoder (
    input  logic [10:0] data_in,
    output logic [15:0] data_out
);

  // internal registers
  logic [ 4:0] p_bits;  // 5 parity bits
  logic [15:0] data_concat;

  // Assign parity bits
  always_comb begin : assign_parity_bits
    p_bits[1] = data_in[0] ^ data_in[1] ^ data_in[3] ^ data_in[4] ^ data_in[6] ^ data_in[8] ^ data_in[10];
    p_bits[2] = data_in[0] ^ data_in[2] ^ data_in[3] ^ data_in[5] ^ data_in[6] ^ data_in[9] ^ data_in[10];
    p_bits[3] = data_in[1] ^ data_in[2] ^ data_in[3] ^ data_in[7] ^ data_in[8] ^ data_in[9] ^ data_in[10];
    p_bits[4] = data_in[4] ^ data_in[5] ^ data_in[6] ^ data_in[7] ^ data_in[8] ^ data_in[9] ^ data_in[10];
    p_bits[0] = ^{data_in, p[4:1]};  // Overall parity
  end

  // concat data and parity
  assign data_out = {data_in[10:4], p_bits[4], data_in[3:1], p_bits[3], data_in[0], p_bits[2:0]};
endmodule
