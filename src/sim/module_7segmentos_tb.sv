`timescale 1ns/1ns

module module_7segmentos_tb;

reg [3:0] in;
wire [6:0] out;

module_7segmentos dut (
    .data(in),
    .display(out)
);

// Generación de estímulos
    initial begin
        $display("-------|---------|--------");
        $display("Tiempo | Entrada | Salida ");
        $display("-------|---------|--------");

        $monitor("Tiempo = %t, Entrada = %b, Salida = %b", $time , in, out);
        
        in = 4'b0000; #10; // Caso 0
        in = 4'b0001; #10; // Caso 1
        in = 4'b0010; #10; // Caso 2
        in = 4'b0011; #10; // Caso 3
        in = 4'b0100; #10; // Caso 4
        in = 4'b0101; #10; // Caso 5
        in = 4'b0110; #10; // Caso 6
        in = 4'b0111; #10; // Caso 7
        in = 4'b1000; #10; // Caso 8
        in = 4'b1001; #10; // Caso 9
        in = 4'b1010; #10; // Caso A
        in = 4'b1011; #10; // Caso B
        in = 4'b1100; #10; // Caso C
        in = 4'b1101; #10; // Caso D
        in = 4'b1110; #10; // Caso E
        in = 4'b1111; #10; // Caso F

    end

     initial begin
        $dumpfile("module_7segmentos_tb.vcd");
        $dumpvars(0, module_7segmentos_tb);
    end
endmodule