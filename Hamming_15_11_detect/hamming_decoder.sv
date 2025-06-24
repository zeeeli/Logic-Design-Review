module hamming_decoder (
    input  logic [15:0] codeword_in,
    output logic        err_detect
);

  logic [        10:0] d;  // Data
  logic [         4:0] p;  // Parity bits
  logic [$size(p)-1:0] check;  // Data bits used for parity calcs
  logic [$size(p)-1:0] s;  // Syndrome

  // NOTE: Bits being packed from MSB - LSB (like encoder)
  assign d = {
    codeword_in[3],  // d0  (position 3)
    codeword_in[5],  // d1  (position 5)
    codeword_in[6],  // d2  (position 6)
    codeword_in[7],  // d3  (position 7)
    codeword_in[9],  // d4  (position 9)
    codeword_in[10],  // d5  (position 10)
    codeword_in[11],  // d6  (position 11)
    codeword_in[12],  // d7  (position 12)
    codeword_in[13],  // d8  (position 13)
    codeword_in[14],  // d9  (position 14)
    codeword_in[15]  // d10 (position 15)
  };

  assign p = {codeword_in[0], codeword_in[1], codeword_in[2], codeword_in[4], codeword_in[8]};

  // ---------- Computing Syndrome bits
  // repeating parity check from encoder
  assign check[0] = ^codeword_in;
  assign check[1] = d[0] ^ d[1] ^ d[3] ^ d[4] ^ d[6] ^ d[8] ^ d[10];
  assign check[2] = d[0] ^ d[2] ^ d[3] ^ d[5] ^ d[6] ^ d[9] ^ d[10];
  assign check[3] = d[1] ^ d[2] ^ d[3] ^ d[7] ^ d[8] ^ d[9] ^ d[10];
  assign check[4] = d[4] ^ d[5] ^ d[6] ^ d[7] ^ d[8] ^ d[9] ^ d[10];

  // Calculate syndrome by comparing received parity bits with check
  assign s[0] = p[0] ^ check[0];
  assign s[1] = p[1] ^ check[1];
  assign s[2] = p[2] ^ check[2];
  assign s[3] = p[3] ^ check[3];
  assign s[4] = p[4] ^ check[4];

endmodule
