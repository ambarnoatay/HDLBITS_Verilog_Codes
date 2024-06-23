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
    parameter left = 3'b000, right = 3'b001, fall_l = 3'b010, fall_r = 3'b011, dig_l = 3'b100,dig_r = 3'b101;
    always @(*) begin
        // State transition logic
        next_state = state;
        case(state)
            left:	
            		if(!ground)
                		next_state = fall_l;
            		else if(dig && ground)
                		next_state = dig_l;
                	else if(bump_left)
                		next_state = right;
            right:	if(!ground)
                		next_state = fall_r;
                else if(dig && ground)
                		next_state = dig_r;
            		
            	else if(bump_right)
                		next_state = left;
            fall_l: if(ground)
                	next_state = left;
            fall_r: if(ground)
                	next_state = right;
            dig_l: if(!ground)
                	next_state = fall_l;
            dig_r: if(!ground)
                next_state = fall_r;
            
            
        endcase
        
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if(areset)
            state = left;
        else
            state = next_state;
    end

    // Output logic
    assign walk_left = state == left?1:0;
    assign walk_right = state == right?1:0;
    assign aaah = state == fall_l?1:state == fall_r?1:0;
    assign digging = state==dig_l?1:state==dig_r?1:0;
    // assign walk_left = (state == ...);
    // assign walk_right = (state == ...);


endmodule

