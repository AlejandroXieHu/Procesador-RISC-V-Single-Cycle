module Register_File (

    input clk,
    input WE3,
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input [31:0] WD3,
    output reg [31:0] RD1,
    output reg [31:0] RD2

);

    reg [31:0] REG [31:0];

    always @(*)
        begin
            if (A1 == 5'b0)
                begin
                    RD1 = 32'b0;
                end
            else
                begin
                    RD1 = REG[A1];
                end

            if (A2 == 5'b0)
                begin
                    RD2 = 32'b0;
                end
            else
                begin
                    RD2 = REG[A2];
                end
        end

    always @(posedge clk)
        begin
            if (WE3 == 1'b1 && A3 != 5'b0)
                begin
                    REG[A3] <= WD3;
                end
        end

endmodule
