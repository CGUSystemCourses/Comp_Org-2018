module state_count(reset, button, state);
	input		reset, button;
	output	[3:0]state;
	
	reg		[3:0]state;
	
	initial begin
		state = 4'b0;
	end
	
	always@ (posedge reset or posedge button) begin
		if(reset)
			state <= 4'b0;
		else 
			if(button == 1'b1) begin
				if(state != 4'b1111)
					state <= state + 1'b1;
				else
					state <= 4'b0;
			end
	end
endmodule
