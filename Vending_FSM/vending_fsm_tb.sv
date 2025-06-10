module vending_fsm_tb;

  logic clk, reset;
  logic one, two, five;
  logic d;
  logic [2:0] r;

  // Instantiate the DUT
  vending_fsm dut (
      .clk(clk),
      .reset(reset),
      .one(one),
      .two(two),
      .five(five),
      .d(d),
      .r(r)
  );

  // Clock generation: 10ns period
  initial clk = 0;
  always #5 clk = ~clk;

  // Stimulus
  initial begin
    $dumpfile("vending_fsm.vcd");
    $dumpvars(0, vending_fsm_tb);

    // Initialize inputs
    reset = 1;
    one   = 0;
    two   = 0;
    five  = 0;
    #12;
    reset = 0;

    // Insert 1 + 2 + 2 = 5 cents → should dispense
    insert_token(1'b1, 1'b0, 1'b0);  // 1 cent
    insert_token(1'b0, 1'b1, 1'b0);  // 2 cent
    insert_token(1'b0, 1'b1, 1'b0);  // 2 cent

    // // Insert 5 directly → should dispense
    // insert_token(1'b0, 1'b0, 1'b1);  // 5 cent
    //
    // // Insert 2 + 2 = 4, then 2 → overpay → r = 1
    // insert_token(1'b0, 1'b1, 1'b0);  // 2 cent
    // insert_token(1'b0, 1'b1, 1'b0);  // 2 cent
    // insert_token(1'b0, 1'b1, 1'b0);  // 2 cent

    // Idle for a few cycles
    #50;
    $finish;
  end

  // Task to insert a token
  task insert_token(input logic one_in, two_in, five_in);
    begin
      @(negedge clk);
      one  = one_in;
      two  = two_in;
      five = five_in;
      @(negedge clk);
      one  = 0;
      two  = 0;
      five = 0;
    end
  endtask

endmodule
