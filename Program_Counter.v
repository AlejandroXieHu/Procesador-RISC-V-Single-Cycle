module Program_Counter (

    input clk,
    input rst,
    input [31:0] pc_next,
    output reg [31:0] pc

);

    reg [31:2] pc_reg;

    always @(posedge clk or posedge rst)
        begin
            if (rst)
                pc_reg <= 30'b0;
            else
                pc_reg <= pc_next[31:2];
        end

    assign pc = {pc_reg, 2'b00};

endmodule
