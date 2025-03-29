`timescale 1ns/1ns

module module_detector_error_tb;

    // Señales de prueba
    reg [6:0] datos_rec; // Entrada de 7 bits [i3,i2,i1,c2,i0,c1,c0]
    wire [2:0] sin;       // Salida de 3 bits [p2,p1,p0]. Síndrome de error
    wire error;           // Salida del bit del error.

    // Instancia del módulo detector_error
    module_detector_error dut(.datos_recibidos(datos_rec), .sindrome(sin), .bit_error(error));

    initial begin
        $display("-------|---------|-------|-------");
        $display("Tiempo | Entrada | Sindrome | Error");
        $display("-------|---------|-------|-------");

        // Caso 1: 1000000
        datos_rec = 7'b100_0000; #10;
        $display("%t  |  %b  |   %b   |   %b", $time, datos_rec, sin, error);

        // Caso 2: 0000111
        datos_rec = 7'b000_0111; #10;
        $display("%t  |  %b  |   %b   |   %b", $time, datos_rec, sin, error);

        // Caso 3: 0011101
        datos_rec = 7'b001_1101; #10;
        $display("%t  |  %b  |   %b   |   %b", $time, datos_rec, sin, error);

        // Caso 4: 1111111
        datos_rec = 7'b111_1111; #10;
        $display("%t  |  %b  |   %b   |   %b", $time, datos_rec, sin, error);

        // Fin de simulación
        $finish;
    end
    initial begin
        $dumpfile("module_detector_error_tb.vcd");
        $dumpvars(0, module_detector_error_tb);
    end
endmodule
