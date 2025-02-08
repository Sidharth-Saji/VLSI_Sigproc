`timescale 1ns / 1ps

module sequence_det(
    input clk,
    input i,
    input reset,
    output y
);
    parameter s0 = 0, s1 = 1, s2 = 2, s3 = 3, s4 = 4, s5 = 5, s6 = 6;  
  	reg [2:0] state;
  	reg out ;

	// Sequential Block
    always @(posedge clk ) begin
        if (reset)
            state <= s0; 
        else begin
            case (state)
                s0: state <= i ? s1 : s0;
                s1: state <= i ? s3 : s2;
                s2: state <= i ? s5 : s6;
                s3: state <= i ? s3 : s4;
                s4: state <= i ? s5 : s0; 
                s5: state <= i ? s3 : s0; 
                s6: state <= i ? s0 : s0; 
            endcase
        end
    end
	
  	// Combinational Block
    always @(*) begin
          case (state)
              s4: out = i ? 1'b0 : 1'b1; 
              s5: out = i ? 1'b0 : 1'b1; 
              s6: out = i ? 1'b1 : 1'b0;  
              default: out = 0;
          endcase
      end
  
  	// Output
	assign y = out;

endmodule
