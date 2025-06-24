module hamming_tb;
  logic [10:0] d_in;
  logic [15:0] enc_word;
  logic [15:0] corr_word;
  logic [15:0] dec_word;
  logic        sed;
  logic        ded;

  // instantiate encoder
  hamming_encoder encoder (
      .data_in (d_in),
      .data_out(enc_word)
  );

  // instantiate decoder
  hamming_decoder decoder (
      .codeword_in(enc_word),
      .codeword_out(dec_word),
      .sed(sed),
      .ded(ded)
  );

  initial begin
    $dumpfile("hamming_tb.vcd");
    $dumpvars(0, hamming_tb);
  end

  initial begin
    // Test vector 1: No error
    d_in = 11'b00110001110;
    #10;

    corr_word = enc_word;  // no error injected
    #10;

    $display("No error test:");
    if (sed || ded) $display("FAIL: Detected error when none injected");
    else $display("PASS: No error detected as expected");

    // Test vector 2: Inject single-bit error
    corr_word = enc_word ^ 16'h0004;  // Flip bit 2 for example
    #10;

    $display("Single-bit error test:");
    if (sed && !ded) $display("PASS: Single-bit error detected");
    else $display("FAIL: Incorrect error detection");

    // check correction:
    if (dec_word !== enc_word) $display("PASS: Codeword corrected");
    else $display("FAIL: No correction applied");

    // Test vector 3: Inject double-bit error
    corr_word = enc_word ^ 16'h0004 ^ 16'h0008;  // Flip two bits
    #10;

    $display("Double-bit error test:");
    if (ded) $display("PASS: Double-bit error detected");
    else $display("FAIL: Double-bit error not detected");

    $finish;
  end

endmodule
