module Instruction_Memory (

	input [31:0] A,
	output [31:0] RD

);

	reg [31:0] instr_mem [0:31]; //0:10_000
	
	initial 
		begin
			$readmemh("instrMem.hex", instr_mem);
		end
	
	assign RD = instr_mem[A[31:2]];

endmodule
