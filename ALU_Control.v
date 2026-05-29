module ALU_Decoder (

    input [1:0] ALUOp,
    input [2:0] funct3,
    input op,
    input funct7_5,
    output reg [2:0] ALUControl

);

    always @(*)
        begin
            if (ALUOp == 2'b00)
                ALUControl = 3'b000; // Suma por defecto (para lw, sw)
            else if (ALUOp == 2'b01)
                ALUControl = 3'b001; // Resta por defecto (para beq)
            else
                begin
                    case (funct3)
                        3'b000:
                            begin
                                if ({op, funct7_5} == 2'b11)
                                    ALUControl = 3'b001; // Operación: Resta (sub)
                                else
                                    ALUControl = 3'b000; // Operación: Suma (add / addi)
                            end
                        3'b010:ALUControl = 3'b101; // Operación: SLT (Set Less Than)
                        3'b011:ALUControl = 3'b011; // Operación: OR lógico
                        3'b111:ALUControl = 3'b010; // Operación: AND lógico
                        default:ALUControl = 3'b000; // Operación por defecto: Suma
                    endcase
                end
        end

endmodule
