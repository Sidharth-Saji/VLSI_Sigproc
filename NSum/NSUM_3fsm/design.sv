// input 3 bit, output 4 bit
module NSum(
  input [2:0] N,
  input N_valid,
  input reset,
  input clk,
  input Ack,
  output reg [3:0] sum,
  output reg sum_valid
);

  reg [2:0] i;
  wire [2:0] in_mux;
  wire [3:0] add_out;
  wire [3:0] sum_mux;
  wire i_eq_1;
  reg [1:0] state; // States Idle and Busy
  parameter idle = 2'b00, 
  			busy = 2'b01,
  			done = 2'b10 ;
  
  // **** Combinational Part *** //
  
  // Input mux part
  assign in_mux = state[0] ? (i-1):N ;
  // Adder part
  assign add_out = sum + i;
  // sum valid before one clock cycle
  assign i_eq_1 = (i==1);
  // Sum block part
  assign sum_mux = (state == idle) ? 4'b0 : (state == busy) ? add_out :
                 (state == done) ? sum : 4'b0;
  
  // **** Sequential Part *** //
  always @(posedge clk)
    begin
      if(reset)state <= idle;
      // i reg
      i <= in_mux;
      // sum reg
      sum <= sum_mux;
      // output qualifier
      sum_valid <= (state == done)?1'b1:1'b0 ;

      //State Update 	
      case (state)
        busy: state <= i_eq_1 ? done : busy;
        idle: state <= N_valid ? busy : idle;
        done: state <= Ack ? idle : done;
      endcase   
    end
endmodule
