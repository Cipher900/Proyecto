`timescale 1ns/1ps

module module_test_tb;


    logic clk;
    logic rst;
    logic [5 : 0] count_o;

    module_test # (10) COUNTER (
        .clk (clk),
        .rst (rst),
        .count_o (count_o) 
    );

    initial begin

        clk = 0;
        rst = 1;

        #30;

        rst = 0;

        #30;

        rst = 1;

        # 300000;
        $finish;
    end

    always begin
        clk = ~clk;
        #10;
    end

    initial begin
        $dumpfile("module_test_tb.vcd");
        $dumpvars(0, module_test_tb);
    end

endmodule