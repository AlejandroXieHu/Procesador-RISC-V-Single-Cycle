module SingleCycle_Top (

    input wire clk,
    input wire rst

);

    wire [31:0] pc_next;
    wire [31:0] pc;
    wire [31:0] PCPlus4;
    wire [31:0] PCTarget;
    wire [31:0] Instr;
    wire [31:0] RD1;
    wire [31:0] WriteData;
    wire [31:0] SrcB;
    wire [31:0] ALUResult;
    wire [31:0] ReadData;
    wire [31:0] Result;
    wire [31:0] ImmExt;
    wire RegWrite;
    wire ALUSrc;
    wire MemWrite;
    wire PCSrc;
    wire [1:0] ImmSrc;
    wire [1:0] ResultSrc;
    wire [2:0] ALUControlSignal;
    wire Zero;
    wire [31:0] ResultStage1;

    Program_Counter program_counter (
        .clk(clk),
        .rst(rst),
        .pc_next(pc_next),
        .pc(pc)
    );

    Instruction_Memory instruction_memory (
        .A(pc),
        .RD(Instr)
    );

    Control_Unit control_unit (
        .op(Instr[6:0]),
        .funct3(Instr[14:12]),
        .funct7_5(Instr[30]),
        .Zero(Zero),
        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),
        .ALUSrc(ALUSrc),
        .MemWrite(MemWrite),
        .ResultSrc(ResultSrc),
        .PCSrc(PCSrc),
        .ALUControl(ALUControlSignal)
    );

    Register_File register_file (
        .clk(clk),
        .WE3(RegWrite),
        .A1(Instr[19:15]),
        .A2(Instr[24:20]),
        .A3(Instr[11:7]),
        .WD3(Result),
        .RD1(RD1),
        .RD2(WriteData)
    );

    Extend extend (
        .Instr(Instr[31:7]),
        .ImmSrc(ImmSrc),
        .ImmExt(ImmExt)
    );

    ALU alu (
        .A(RD1),
        .B(SrcB),
        .ALUControl(ALUControlSignal),
        .Result(ALUResult),
        .Zero(Zero)
    );

    Data_Memory data_memory (
        .clk(clk),
        .WE(MemWrite),
        .A(ALUResult),
        .WD(WriteData),
        .RD(ReadData)
    );

    Adder pc4 (
        .A(pc),
        .B(32'd4),
        .res(PCPlus4)
    );

    Adder result (
        .A(pc),
        .B(ImmExt),
        .res(PCTarget)
    );

    Multiplexor mux_pc (
        .d0(PCPlus4),
        .d1(PCTarget),
        .selector(PCSrc),
        .out(pc_next)
    );

    Multiplexor mux_alu (
        .d0(WriteData),
        .d1(ImmExt),
        .selector(ALUSrc),
        .out(SrcB)
    );

    Multiplexor mux_resa (
        .d0(ALUResult),
        .d1(ReadData),
        .selector(ResultSrc[0]),
        .out(ResultStage1)
    );

    Multiplexor mux_resb (
        .d0(ResultStage1),
        .d1(PCPlus4),
        .selector(ResultSrc[1]),
        .out(Result)
    );

endmodule
