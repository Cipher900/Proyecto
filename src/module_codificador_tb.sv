`timescale 1ns/1ps

module codificador_tb;

    reg  [3:0] data_in;    // Entrada de 4 bits
    wire [6:0] encoded;    // Salida codificada de 7 bits

    // Instanciamos el módulo del codificador
    codificador uut (.data_in(data_in),.encoded(encoded));

    initial begin
        // Cabecera para imprimir resultados
        $display("Tiempo | Entrada | Codificado (7 bits)");
        $display("-------|--------|------------------");

        // Prueba con diferentes valores de entrada
        data_in = 4'b0000; #10;
        $display("%t  |  %b  |   %b", $time, data_in, encoded);

        data_in = 4'b0001; #10;
        $display("%t  |  %b  |   %b", $time, data_in, encoded);

        data_in = 4'b0010; #10;
        $display("%t  |  %b  |   %b", $time, data_in, encoded);

        data_in = 4'b0011; #10;
        $display("%t  |  %b  |   %b", $time, data_in, encoded);

        data_in = 4'b0100; #10;
        $display("%t  |  %b  |   %b", $time, data_in, encoded);

        data_in = 4'b0101; #10;
        $display("%t  |  %b  |   %b", $time, data_in, encoded);

        data_in = 4'b0110; #10;
        $display("%t  |  %b  |   %b", $time, data_in, encoded);

        data_in = 4'b0111; #10;
        $display("%t  |  %b  |   %b", $time, data_in, encoded);

        data_in = 4'b1000; #10;
        $display("%t  |  %b  |   %b", $time, data_in, encoded);

        data_in = 4'b1001; #10;
        $display("%t  |  %b  |   %b", $time, data_in, encoded);

        data_in = 4'b1010; #10;
        $display("%t  |  %b  |   %b", $time, data_in, encoded);

        data_in = 4'b1011; #10;
        $display("%t  |  %b  |   %b", $time, data_in, encoded);

        data_in = 4'b1100; #10;
        $display("%t  |  %b  |   %b", $time, data_in, encoded);

        data_in = 4'b1101; #10;
        $display("%t  |  %b  |   %b", $time, data_in, encoded);

        data_in = 4'b1110; #10;
        $display("%t  |  %b  |   %b", $time, data_in, encoded);

        data_in = 4'b1111; #10;
        $display("%t  |  %b  |   %b", $time, data_in, encoded);

        #10;
        $finish; // Finaliza la simulación
    end

endmodule
