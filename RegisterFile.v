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

    reg [31:0] rf [31:0];

    always @(posedge clk)
        begin
            if (WE3 && (A3 != 5'b0))
                begin
                    rf[A3] <= WD3;
                end
        end

    always @(*)
        begin
            if (A1 == 5'b0)
                RD1 = 32'b0;
            else
                RD1 = rf[A1];

            if (A2 == 5'b0)
                RD2 = 32'b0;
            else
                RD2 = rf[A2];
        end

endmodule
