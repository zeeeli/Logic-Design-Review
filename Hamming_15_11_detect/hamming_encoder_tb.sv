module hamming_encoder_tb;

  logic [10:0] in;
  logic [15:0] out;

  hamming_encoder uut (
      .data_in (in),
      .data_out(out)
  );

  // Stimulus
  initial begin
    $dumpfile("hamming_encoder.vcd");
    $dumpvars(0, hamming_encoder_tb);
  end

  initial begin
    in = 11'b00110001110;
    #10;
    in = $urandom;
    #10;
    in = $urandom;
    #10;
    in = $urandom;
    #10;
    in = $urandom;
    #10;
    $finish;
  end
endmodule
