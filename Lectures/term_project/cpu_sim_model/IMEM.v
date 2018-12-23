module IMEM(Address,Instruction_out);
	input [7:0] Address;
	output [15:0] Instruction_out;
	reg [15:0] Instruction_out;
	reg [15:0] Instruction_memory [0:255];
	initial $readmemb("imem.txt", Instruction_memory);
	always @(*) begin
		assign Instruction_out = Instruction_memory[Address];
	end
endmodule
