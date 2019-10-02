module button(reset, clk_50M, key, hex0);
	input		reset, clk_50M;
	input		key;
	output	[6:0]hex0;
	
	wire 		button;
	wire		[3:0]num0;

	debounce key_db(.reset(reset), .clk_in(clk_50M), .button_in(key), .button_out(button));
	state_count s0(.reset(reset), .button(button), .state(num0));
	seg_7 seg7_0 (.num(num0), .hex(hex0));
endmodule
