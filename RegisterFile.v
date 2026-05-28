module RegisterFile (

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

    always @(posedge clk)
        begin
            RD1 = REG[A1];
            RD2 = REG[A2];
        end

    always @(*)
        begin
            if (WE3 == 1)
                REG[A3] = WD3;
        end

endmodule
