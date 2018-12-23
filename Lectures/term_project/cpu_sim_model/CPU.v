module CPU(IR,Data_in,PC,Address_out,Data_out,MW,clk,reset);
	input clk,reset;
	input [15:0] IR;
	input [7:0] Data_in;
	output MW;
	output [7:0] PC,Address_out,Data_out;
	reg [7:0] PC,Address_out,Data_out,OP;
	reg [6:0] Opcode;
	reg [7:0] R [0:7];
	reg [5:0] AD;
	reg [2:0] DR,SA,SB;
	reg MW;
	initial begin
		//if(reset == 1)
			//PC = 0;
	end
	always @ (posedge clk) begin
		if(reset)begin
			PC = 0;
		end
		else begin
		Opcode = IR[15:9];
		DR = IR[8:6];
		SA = IR[5:3];
		SB = IR[2:0];
		OP = {4'b0000,IR[2:0]};
		AD = {IR[8:6],IR[2:0]};
		Address_out = R[SA];
		MW = IR[14]&!IR[15];
		if ((IR[15]&&IR[14])==0)
			PC = PC+1;
		#1
		case(Opcode)
			7'b0000000: R[DR]=R[SA];//MOVA
			7'b0000001: R[DR]=R[SA]+1;//INC
			7'b0000010: R[DR]=R[SA]+R[SB];//ADD
			7'b0000101: R[DR]=R[SA]-R[SB];//SUB
			7'b0000110: R[DR]=R[SA]-1;//DEC
			7'b0001000: R[DR]=R[SA]&R[SB];//AND
			7'b0001001: R[DR]=R[SA]|R[SB];//OR
			7'b0001010: R[DR]=R[SA]^R[SB];//XOR
			7'b0001011: R[DR]=~R[SA]+1;//NOT
			7'b0001100: R[DR]=R[SB];//MOVB
			7'b0001101: R[DR]=R[SB]>>1;//SHR
			7'b0001110: R[DR]=R[SB]<<1;//SHL
			7'b1001100: R[DR]=OP;//LDI
			7'b1000010: R[DR]=R[SA]+OP;//ADI
			7'b0010000: R[DR]=Data_in;//LD
			7'b0100000: Data_out=R[SB];//ST
			7'b1100000: 
				begin
					if(R[SA]==0) PC = PC+AD;
					else PC = PC+1;
				end//BRZ
			7'b1100001: 
				begin
					if(R[SA]<0) PC = PC+AD;
					else PC = PC+1;
				end //BRN
			7'b1110000: PC = R[SA];//JMP
		endcase
		end
	end
endmodule
