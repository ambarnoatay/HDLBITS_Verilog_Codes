module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
     reg [1:0] state, next_state;
	parameter LEFT = 2'b00, RIGHT = 2'b01, FALL_L = 2'b10, FALL_R = 2'b11;
    always @(*) begin
        // State transition logic
        next_state = state;
        case(state)
            LEFT: if(!ground)
                	next_state = FALL_L;
                else if(bump_left)
                	next_state = RIGHT;
            RIGHT:if(!ground)
                	next_state = FALL_R;
                else if(bump_right)
                	next_state = LEFT;
            FALL_L: if(ground)
                	next_state = LEFT;
            FALL_R: if(ground)
                	next_state = RIGHT;
            
            
        endcase
        
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if(areset)
            state = LEFT;
        else
            state = next_state;
    end

    // Output logic
    assign walk_left = state == LEFT?1:0;
    assign walk_right = state == RIGHT?1:0;
    assign aaah = state == FALL_L?1:state == FALL_R?1:0;
    // assign walk_left = (state == ...);
    // assign walk_right = (state == ...);

endmodule



