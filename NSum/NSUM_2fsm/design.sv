// input 3 bit, output 4 bit
module NSum(
  input [2:0] N,
  input N_valid,
  input reset,
  input clk,
  output reg [3:0] sum,
  output reg sum_valid
);

  reg [2:0] i;
  wire [2:0] in_mux;
  wire [3:0] add_out;
  wire [3:0] sum_mux;
  wire i_eq_1;
  reg state; // States Idle and Busy
  parameter idle = 0, busy = 1;
  
  // **** Combinational Part *** //
  
  // Input mux part
  assign in_mux = state ? (i-1):N ;
  // Adder part
  assign add_out = sum + i;
  // Sum block part
  assign sum_mux =  state ? add_out : 4'b0000 ;
  // sum valid before one clock cycle
  assign i_eq_1 = (i==1);
  
  // **** Sequential Part *** //
  always @(posedge clk)
    begin
      if(reset)state <= idle;
      // i reg
      i <= in_mux;
      // sum reg
      sum <= sum_mux;
      // output qualifier
      sum_valid <= i_eq_1;

      //State Update 	
      case (state)
        busy: state <= i_eq_1 ? idle : busy;
        idle: state <= N_valid ? busy : idle;
      endcase
        
    end
endmodule