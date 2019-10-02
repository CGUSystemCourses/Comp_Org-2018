module debounce(reset, clk_in, button_in, button_out);
	input		reset, clk_in, button_in;
	output 	button_out;
	
	reg button_out;
	reg [25:0] counter;
	
	parameter divn_num = 5000000;
	
	always @(posedge clk_in) begin
		if(reset == 1'b1) begin
			counter = 5000000;
		end
		else begin
			if(button_in == 1'b1)
				counter = 0;
			else
				if(counter != 5000000)
					counter = counter + 1;
		end
	end
	
	always @(*) begin
		 if(counter == 4999999) begin
			  button_out <= 1'b1;
		 end
		 else 
			  button_out <= 1'b0;
	end
endmodule
