module DataMemory (

    input wire clk,
    input wire WE,
    input wire [31:0] A,
    input wire [31:0] WD,
    output wire [31:0] RD

);

    reg [31:0] ram [255:0];

    always @(posedge clk)
        begin
            if (WE)
                ram[A[31:2]] <= WD;
        end

        assign RD = ram[A[31:2]];

endmodule
