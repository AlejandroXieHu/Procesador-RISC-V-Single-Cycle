module Control_Unit (

    input [6:0] op,
    input [2:0] funct3,
    input funct7_5,
    input Zero,
    output PCSrc,
    output [1:0] ResultSrc,
    output [2:0] ALUControl,
    output ALUSrc,
    output [1:0] ImmSrc,
    output RegWrite,
    output MemWrite

);

    wire [1:0] ALUOp;
    wire MainPCSrc;

    Main_Decoder main_decoder (
        .op(op),
        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),
        .ALUSrc(ALUSrc),
        .MemWrite(MemWrite),
        .ResultSrc(ResultSrc),
        .PCSrc(MainPCSrc),
        .ALUOp(ALUOp)
    );

    ALU_Decoder alu_decoder (
        .ALUOp(ALUOp),
        .funct3(funct3),
        .op(op[5]),
        .funct7_5(funct7_5),
        .ALUControl(ALUControl)
    );

    assign PCSrc = MainPCSrc & Zero;

endmodule
