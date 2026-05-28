module ALU_Control (

    input [1:0] ALUOp,
    input [2:0] funct3,
    input op,
    input funct7_5,
    output reg [2:0] ALUControl

);

    always @(*)
        begin
            if (ALUOp == 2'b00)
                ALUControl = 3'b000;
            else if (ALUOp == 2'b01)
                ALUControl = 3'b001;
            else
                begin
                    case (funct3)
                        3'b000:
                            begin
                                if ({op, funct7_5} == 2'b11)
                                    ALUControl = 3'b001;
                                else
                                    ALUControl = 3'b000;
                            end
                        3'b010:ALUControl = 3'b101;
                        3'b011:ALUControl = 3'b011;
                        3'b111:ALUControl = 3'b010;
                        default:ALUControl = 3'b000;
                    endcase
                end
        end

endmodule
