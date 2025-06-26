module hamming_tb;
  logic [10:0] d_in;
  logic [15:0] enc_word;
  logic [15:0] corr_word;
  logic [15:0] dec_word;
  logic [15:0] codeword_in_tb;
  logic        sed;
  logic        ded;

  // instantiate encoder
  hamming_encoder encoder (
      .data_in (d_in),
      .data_out(enc_word)
  );

  // instantiate decoder
  hamming_decoder decoder (
      .codeword_in(codeword_in_tb),
      .codeword_out(dec_word),
      .sed(sed),
      .ded(ded)
  );

  initial begin
    $dumpfile("hamming_tb.vcd");
    $dumpvars(0, hamming_tb);
  end

  task run_no_error_test(input [10:0] din);
    d_in = din;
    #1;

    codeword_in_tb = enc_word;  // no error injected
    #1;

    $display("Original data      = %b", d_in);
    $display("Encoded codeword   = %b", enc_word);
    $display("Decoder input      = %b", codeword_in_tb);
    $display("Decoder output     = %b", dec_word);
    $display("SED: %b, DED: %b", sed, ded);

    if (!sed && !ded && dec_word == enc_word) $display("✅ No-error test passed.\n");
    else $display("❌ No-error test failed.\n");
  endtask

  // Procedure for single-bit error test
  task run_single_error_test(input [10:0] din, input int err_bit);
    d_in = din;
    #1;  // allow encoder to update

    $display("Original data      = %b", d_in);
    $display("Encoded codeword   = %b", enc_word);

    // Inject 1-bit error
    codeword_in_tb = enc_word ^ (16'b1 << err_bit);
    #1;

    $display("Corrupted codeword = %b", decoder.codeword_in);
    $display("Corrected codeword = %b", dec_word);
    $display("SED: %b, DED: %b", sed, ded);

    if (sed && !ded && dec_word == enc_word)
      $display("✅ Single-bit error correctly detected and corrected.\n");
    else $display("❌ Single-bit error test failed.\n");
  endtask

  // Procedure for double-bit error test
  task run_double_error_test(input [10:0] din, input int err_bit1, input int err_bit2);
    d_in = din;
    #1;

    // Inject 2-bit error
    codeword_in_tb = enc_word ^ ((16'b1 << err_bit1) | (16'b1 << err_bit2));
    #1;

    $display("Original data      = %b", d_in);
    $display("Encoded codeword   = %b", enc_word);
    $display("Corrupted codeword = %b", decoder.codeword_in);
    $display("Corrected codeword = %b", dec_word);
    $display("SED: %b, DED: %b", sed, ded);

    if (!sed && ded) $display("✅ Double-bit error correctly detected (not corrected).\n");
    else $display("❌ Double-bit error test failed.\n");
  endtask

  // Main test logic
  initial begin
    $display("Starting Hamming Encoder/Decoder Testbench...\n");
    run_no_error_test(11'b11100011100);  // No error test
    run_single_error_test(11'b10100100100, 5);  // Flip bit 5
    run_single_error_test(11'b00110001110, 13);  // Flip bit 13
    run_double_error_test(11'b10100100100, 5, 10);  // Flip two bits

    $display("All tests complete.");
    $finish;
  end

  // initial begin
  //   // Test vector 1: No error
  //   d_in = 11'b00110001110;
  //   corr_word = enc_word;  // no error injected
  //   #10;
  //
  //   $display("No error test:");
  //   if (sed || ded) $display("FAIL: Detected error when none injected");
  //   else $display("PASS: No error detected as expected");
  //
  //   // Test vector 2: Inject single-bit error
  //   corr_word = enc_word ^ 16'h0004;  // Flip bit 2 for example
  //   #10;
  //
  //   $display("Single-bit error test:");
  //   if (sed && !ded) $display("PASS: Single-bit error detected");
  //   else $display("FAIL: Incorrect error detection");
  //
  //   // check correction:
  //   if (dec_word !== enc_word) $display("PASS: Codeword corrected");
  //   else $display("FAIL: No correction applied");
  //
  //   // Test vector 3: Inject double-bit error
  //   corr_word = enc_word ^ 16'h0004 ^ 16'h0008;  // Flip two bits
  //   #10;
  //
  //   $display("Double-bit error test:");
  //   if (ded) $display("PASS: Double-bit error detected");
  //   else $display("FAIL: Double-bit error not detected");
  //
  //   $finish;
  // end

endmodule
