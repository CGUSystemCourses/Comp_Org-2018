/*******************************************************************************
 *
 * RTL source: [freq_div_1Hz.v]
 *
 ******************************************************************************/



/*******************************************************************************
 *
 * module freq_div_1Hz:
 *
 *	- a clock-frequency divider
 *	- to generate 1Hz clock in 50% duty cycle from the 500MHz clock input
 *	  of the DE2-115 board
 *
 ******************************************************************************/

`define CLK_IN_FREQ		50000000
`define HALF_FREQ		25000000

//
// smaller value for testing
//
//`define CLK_IN_FREQ		500
//`define HALF_FREQ		250

module freq_div_1Hz (
	clk_in,
	clk_out,
	reset
);

input		clk_in;
output		clk_out;
input		reset;

reg		[27:0]		counter;
wire				counter_top;
wire				half_high;
reg					clk_out;

assign counter_top = (counter==(`CLK_IN_FREQ-1))? 1'b1: 1'b0;
assign half_high = (counter<`HALF_FREQ)? 1'b1: 1'b0;

always @(posedge clk_in) begin
	if (reset)
		counter <= 0;
	else if (counter_top)
		counter <= 0;
	else
		counter <= counter+1;
end

always @(posedge clk_in) begin
	if (reset)
		clk_out <= 1'b0;
	else
		clk_out <= half_high;
end

endmodule

