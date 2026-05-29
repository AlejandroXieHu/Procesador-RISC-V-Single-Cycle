module SingleCycle_Top_tb;

    reg clk;
    reg rst;

    SingleCycle_Top dut (
        .clk(clk),
        .rst(rst)
    );

    always 
        begin
            #5 clk = ~clk;
        end

    initial
        begin
            clk = 0;
            rst = 1; // Activa el reset del procesador para inicializar los registros a cero
            #20;
            rst = 0; // Desactiva el reset para liberar la ejecución del procesador

            repeat (10)
                begin
                    #10;
                end
            $finish;
        end

    initial
        begin
            $monitor("%4t | PC = %h | Instr = %h | ALURes = %h | RegWrite = %b | Zero = %b | PCSrc = %b", $time, dut.pc, dut.Instr, dut.ALUResult, dut.RegWrite, dut.Zero, dut.PCSrc);
        end

    initial 
        begin
            $dumpfile("SingleCycle_Top_tb.vcd");
            $dumpvars(0, SingleCycle_Top_tb);
        end

endmodule
