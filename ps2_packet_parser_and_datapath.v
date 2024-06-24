module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //
	
    reg [23:0] temp_out;
    reg [1:0] state,next_state;
    parameter b1 = 2'b00, b2 = 2'b01, b3 = 2'b10,fin=2'b11;
    // State transition logic (combinational)
    always@(*) begin
    	state = next_state;
        
    end
        
    // State flip-flops (sequential)
        always@(posedge clk)
            begin
                if(reset) begin
                    next_state <= b1;
                	temp_out <= 24'b0;
                end
                else
            case(state)
           
                b1:  if(in[3]) begin 
                    temp_out [23:16] <= in;
                	next_state <= b2;
                    
                end
            b2: begin
                temp_out[15:8] <= in;
                next_state <= b3;
            end
            b3: begin
                temp_out[7:0] <= in;
                next_state <= fin;
            end
                fin: if(in[3]) begin 
                    temp_out[23:16]<=in;	
                    next_state <= b2;
                end
                	else
                        next_state <= b1;
            
        endcase
                    
            end
    // Output logic
    assign done = state == fin;
    assign out_bytes = state==fin?temp_out:24'b0;




    
endmodule

