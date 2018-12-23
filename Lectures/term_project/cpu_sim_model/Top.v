module Top;
	reg clk,reset;
	wire [7:0] PC,Address_out,Data_out,Data_in;
	wire [15:0] IR;
	wire MW;
	CPU cpu(IR,Data_in,PC,Address_out,Data_out,MW,clk,reset);
	IMEM imem(.Address(PC),.Instruction_out(IR));
	DMEM dmem(.MW(MW),.Address(Address_out),.Data_in(Data_out),.Data_out(Data_in),.clk(clk));
	initial begin
		clk = 1;
		reset = 1;
		#10 reset = 0;
	end
	always begin
		#10 clk = ~clk;
	end
endmodule
