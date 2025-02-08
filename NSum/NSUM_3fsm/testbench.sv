module NSum_tb;
  reg [2:0] N;
  reg N_valid;
  reg reset;
  reg clk;
  reg Ack;  // Changed to reg
  wire [3:0] sum;
  wire sum_valid;

  // Instantiate the NSum module
  NSum uut (
    .N(N), 
    .N_valid(N_valid), 
    .reset(reset), 
    .clk(clk), 
    .sum(sum),
    .sum_valid(sum_valid), 
    .Ack(Ack)
  );

  initial begin
    $dumpfile("NSum.vcd");
    $dumpvars(0, NSum_tb); // Dump variables
  end

  // Clock Generation
  initial begin
    clk = 1;
    forever #5 clk = ~clk; // 10ns clock
  end

  initial begin
    // Initialize Inputs
    N_valid = 0;
    reset = 0;
    Ack = 0;

    // Initial Reset
    #2 reset = 1; 
    #10 reset = 0;

    // Apply N = 5
    #5 N = 5; N_valid = 1;
    #10 N_valid = 0;
    #20 N = 4; N_valid = 1;
    #10 N_valid = 0;

    // Acknowledge after 200ns
    #100 Ack = 1;
	#10 Ack = 0;
    #50 $finish;
  end
endmodule
