`timescale 1ns/1ns

module module_corrector_error_tb;
        // Señales de prueba
    reg [6:0] datos_rec; //Entrada: Datos recibidos
    reg [2:0] sin; //Entrada: Síndrome de error
    wire [6:0] datos_co; //Salida: Datos corregidos

    // Instancia del módulo a probar 

    module_corrector_error dut (
        .sindrome(sin),
        .datos_recibidos(datos_rec),
        .data(datos_co)
    );

    // Generación de estímulos
    initial begin
        $display("-------|---------|----------|-------");
        $display("Tiempo | Entrada | Sindrome | Salida");
        $display("-------|---------|----------|-------");

       //Caso 1: Sin error
       datos_rec=7'b000_0111; sin=3'b000;
       $display("%t  |  %b  |   %b   |   %b", $time, datos_rec, sin, datos_co); #10;

       //Caso 2: Error en el bit 1
       datos_rec=7'b000_0110; sin=3'b001;
       $display("%t  |  %b  |   %b   |   %b", $time, datos_rec, sin, datos_co); #10;

       //Caso 3: Sin error
         datos_rec=7'b111_1111; sin=3'b111;
         $display("%t  |  %b  |   %b   |   %b", $time, datos_rec, sin, datos_co); #10;

    end

    initial begin
        $dumpfile("module_corrector_error_tb.vcd");
        $dumpvars(0, module_corrector_error_tb);
    end
endmodule
