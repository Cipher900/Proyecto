`timescale 1ns / 1ns

module module_decodificador_tb;
    
    // Señales de prueba
    reg [6:0] recibido;  // Entrada: Palabra de 7 bits corregida
    wire [3:0] salida; // Salida: Datos originales de 4 bits

    // Instanciar el módulo decodificador
    module_decodificador dut (.datos_cod(recibido),.datos_out(salida));

    // Procedimiento de prueba
    initial begin
        $display("-------|---------|-------");
        $display("Tiempo | Entrada | Salida");
        $display("-------|---------|-------");
        // Caso 1: 0000000
        recibido = 7'b000_0000; #10;
        $display("%t  |  %b  |   %b", $time, recibido, salida);
        // Caso 2: 0000111
        recibido = 7'b000_0111; #10;
        $display("%t  |  %b  |   %b", $time, recibido, salida);
        // Caso 3: 0011001
        recibido = 7'b001_1001; #10;
        $display("%t  |  %b  |   %b", $time, recibido, salida);
        
        // Fin de simulación
        $finish;
    end
    
    initial begin
        $dumpfile("module_decodificador_tb.vcd");
        $dumpvars(0, module_decodificador_tb);
    end

endmodule
