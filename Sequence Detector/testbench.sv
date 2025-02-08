`timescale 1ns / 1ps

module NSum_tb;

  // Inputs
  reg [2:0] N;
  reg N_valid;
  reg reset;
  reg clk;

  // Outputs
  wire [3:0] sum;
  wire sum_valid;

  // Instantiate the NSum module
  NSum uut (
    .N(N),
    .N_valid(N_valid),
    .reset(reset),
    .clk(clk),
    .sum(sum),
    .sum_valid(sum_valid)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10ns clock period
  end

  // Testbench logic
  initial begin
    // Initialize inputs
    N = 0;
    N_valid = 0;
    reset = 0;

    // Reset the module
    #2 reset = 1;  // Apply reset
    #10 reset = 0; // Release reset

    // Test case 1: Apply a value of N
    #5 N = 3; N_valid = 1;
    #10 N_valid = 0;

    // Test case 2: Apply another value of N
    #20 N = 5; N_valid = 1;
    #10 N_valid = 0;

    // Test case 3: Reset during operation
    #20 reset = 1;
    #10 reset = 0;

    // Test case 4: Check with another value
    #10 N = 2; N_valid = 1;
    #10 N_valid = 0;

    // End simulation
    #50 $finish;
  end

  // Monitor output
  initial begin
    $monitor("Time = %0d, N = %b, N_valid = %b, reset = %b, sum = %b, sum_valid = %b",
             $time, N, N_valid, reset, sum, sum_valid);
  end

endmodule
