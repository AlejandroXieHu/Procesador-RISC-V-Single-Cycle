module ALU (

    input [31:0] A,
    input [31:0] B,
    input [2:0] ALUControl,
    output reg [31:0] Result,
    output reg Zero

);

    reg [31:0] Resta_SLT;

    always @(*)
        begin

            Resta_SLT = A - B;

            case (ALUControl)
                3'b000:Result = A + B;
                3'b001:Result = A - B;
                3'b010:Result = A & B;
                3'b011:Result = A | B;
                3'b101:
                    begin
                        if (Resta_SLT[31] == 1'b1)
                            Result = 32'd1;
                        else
                            Result = 32'd0;
                    end
                default:Result = 32'b0;
            endcase

            if (Result == 32'd0)
                Zero = 1'b1;
            else
                Zero = 1'b0;
        end

endmodule
