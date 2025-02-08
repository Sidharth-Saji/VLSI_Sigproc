module NSum_tb;
  reg [2:0] N;
  reg N_valid;
  reg reset;
  reg clk;
  wire [3:0] sum;
  wire sum_valid;

  NSum uut ( .N(N), .N_valid(N_valid), .reset(reset), 					.clk(clk), .sum(sum),.sum_valid(sum_valid)
           );

  initial begin
    $dumpfile("NSum.vcd");
    $dumpvars(0);
  end

  // Clock 
  initial begin
    clk = 1;
    forever #5 clk = ~clk; // 10ns clock 
  end

  initial begin
    N_valid = 0;
    reset = 0;

    // Initial Reset
    #2 reset = 1; 
    #10 reset = 0;

    // Apply N = 3
    #5 N = 5; N_valid = 1;
    #10 N_valid = 0;
	#20  N = 4; N_valid = 1;
    #10 N_valid = 0;
    #200
    $finish;
  end
endmodule
