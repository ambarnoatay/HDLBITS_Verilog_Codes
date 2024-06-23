module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right); //  

    parameter LEFT=0, RIGHT=1;
    reg state, next_state;

    always @(*) begin
        // State transition logic
        next_state = state;
        case(state)
            LEFT: if(bump_left)
                	next_state = RIGHT;
            
            RIGHT: if(bump_right)
                	next_state = LEFT;
            
            	
            	
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
    assign walk_left = state==LEFT?1:0;
    assign walk_right = state ==RIGHT?1:0;
    // assign walk_left = (state == ...);
    // assign walk_right = (state == ...);

endmodule

