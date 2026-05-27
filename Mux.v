module Mux (

    input wire [31:0] d0,
    input wire [31:0] d1,
    input wire selector,
    output reg [31:0] out

);

    always @(*)
        begin
            case (selector)
                1'b0:out = d0;
                1'b1:out = d1;
                default:out = 32'b0;
            endcase
        end

endmodule
