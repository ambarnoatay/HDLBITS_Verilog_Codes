module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done); //
    reg [1:0] state,next_state;
    parameter b1 = 2'b00, b2 = 2'b01, b3 = 2'b10,fin=2'b11;
    // State transition logic (combinational)
    always@(*) begin
    	state = next_state;
        
    end
        
    // State flip-flops (sequential)
        always@(posedge clk)
            begin
                if(reset)
                    next_state <= b1;
                else
            case(state)
           
            b1:  if(in[3])
                	next_state <= b2;
            	
            b2: next_state <= b3;
            b3: next_state <= fin;
              fin: if(in[3])
                    	next_state <= b2;
                	else
                        next_state <= b1;
            
        endcase
                    
            end
    // Output logic
    assign done = state == fin;

endmodule

