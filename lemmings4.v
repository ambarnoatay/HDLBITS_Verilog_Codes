module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
    reg [2:0] state,next_state;
    int cnt;
    parameter left = 3'b000, right = 3'b001, fall_l = 3'b010, fall_r = 3'b011, dig_l = 3'b100,dig_r = 3'b101,die=3'b111,
    splatter = 3'b110;
    always @(*) begin
        // State transition logic
        next_state = state;
        
   	
        case(state)
            left:	if(!ground) begin 
			   
                		next_state = fall_l;
			end
            		else if(dig)
                		next_state = dig_l;
                	else if(bump_left)
                		next_state = right;
			right:	if(!ground) begin 
                		next_state = fall_r;
			end
                else if(dig)
                		next_state = dig_r;
            		
            	else if(bump_right)
                		next_state = left;
            fall_l: if(cnt>18)
                		next_state = die;
                else if(ground) begin 
                		
                	next_state = left;
            		end	
            fall_r:if(cnt >18)
                		next_state = die;
                else if(ground) begin 
                	
                	next_state = right;
           		 end	
            dig_l: if(!ground)
                	next_state = fall_l;
            dig_r: if(!ground)
                next_state = fall_r;
            die: if(ground)
                	next_state = splatter;
            
        endcase
        
    end



    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if(areset)
            state = left;
        else if(state == fall_l|| state==fall_r) begin
            cnt = cnt+1;
            state = next_state;
        end
        else begin 
            cnt = 0;
            state = next_state;
        end
    end

    // Output logic
    assign walk_left = state == left;
    assign walk_right = state == right;
    assign aaah = state == fall_l? 1: (state==fall_r?1:(state==die?1:0));
    assign digging = state == dig_l? 1: (state==dig_r?1:0);
    // assign walk_left = (state == ...);
    // assign walk_right = (state == ...);


endmodule




