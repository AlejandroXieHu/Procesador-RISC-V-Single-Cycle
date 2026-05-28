module Main_Decoder (

    input wire [6:0] op,
    output reg RegWrite,
    output reg [1:0] ImmSrc,
    output reg ALUSrc,
    output reg MemWrite,
    output reg [1:0] ResultSrc,
    output reg PCSrc,
    output reg [1:0] ALUOp

);

    always @(*)
        begin
            case (op)
                7'b0000011: // lw
                    begin
                        RegWrite = 1'b1; ImmSrc = 2'b00; ALUSrc = 1'b1;
                        MemWrite = 1'b0; ResultSrc = 2'b01; PCSrc = 1'b0; ALUOp = 2'b00;
                    end
                7'b0100011: // sw
                    begin
                        RegWrite = 1'b0; ImmSrc = 2'b01; ALUSrc = 1'b1;
                        MemWrite = 1'b1; ResultSrc = 2'b00; PCSrc = 1'b0; ALUOp = 2'b00;
                    end
                7'b0110011: // Type-R
                    begin
                        RegWrite = 1'b1; ImmSrc = 2'b00; ALUSrc = 1'b0;
                        MemWrite = 1'b0; ResultSrc = 2'b00; PCSrc = 1'b0; ALUOp = 2'b10;
                    end
                7'b1100011: // beq
                    begin
                        RegWrite = 1'b0; ImmSrc = 2'b10; ALUSrc = 1'b0;
                        MemWrite = 1'b0; ResultSrc = 2'b00; PCSrc = 1'b1; ALUOp = 2'b01;
                    end
                    default:
                        begin
                            RegWrite = 1'b0; ImmSrc = 2'b00; ALUSrc = 1'b0;
                            MemWrite = 1'b0; ResultSrc = 2'b00; PCSrc = 1'b0; ALUOp = 2'b00;
                        end
            endcase
        end

endmodule
