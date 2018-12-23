module DMEM(MW,Address,Data_in,Data_out,clk);
	input MW,clk;
	input [7:0] Address,Data_in;
	output [7:0] Data_out;
	reg [7:0] Data_out;
	reg [7:0] Data_memory [0:255];
	initial $readmemb("dmem.txt", Data_memory);
	always @(posedge clk) begin
		if(MW) begin
			Data_memory[Address] = Data_in;
			$writememb("dmem.txt", Data_memory);
		end
	end
	always @(*) begin
		assign Data_out = Data_memory[Address];
	end
endmodule
