`timescale 1ns/1ns

module module_corrector_error_tb;
        // Señales de prueba
    reg [6:0] datos_recibidos; //Entrada: Datos recibidos
    reg [2:0] sindrome; //Entrada: Síndrome de error
    wire [6:0] data; //Salida: Datos corregidos

    // Instancia del módulo a probar 

    module_corrector_error dut (
        .sindrome(sindrome),
        .datos_recibidos(datos_recibidos),
        .data(data)
    );

    // Generación de estímulos
    initial begin
        $display("-------|---------|----------|-------");
        $display("Tiempo | Entrada | Sindrome | Salida");
        $display("-------|---------|----------|-------");

        //Caso 1: Sin error
        //datos_recibidos =7'b000_0111; sindrome=3'b000;
        //$display("%t  |  %b  |   %b   |   %b", $time, datos_recibidos, sindrome, data); #10;

        //Caso 2: Error en el bit 1
        //datos_recibidos=7'b000_0110; sindrome=3'b001;
        //$display("%t  |  %b  |   %b   |   %b", $time, datos_recibidos, sindrome, data); #20;

        //Caso 3: Sin error
        //datos_recibidos=7'b111_1111; sindrome=3'b111;
        //$display("%t  |  %b  |   %b   |   %b", $time, datos_recibidos, sindrome, data); #30;

        $monitor("Sindrome = %b, Datos recibidos = %b, Data = %b", sindrome, datos_recibidos, data);

        sindrome = 3'b000; datos_recibidos = 7'b1010101; #10; // Caso 1
        sindrome = 3'b001; datos_recibidos = 7'b1110001; #10; // Caso 2
        sindrome = 3'b010; datos_recibidos = 7'b1101010; #10; // Caso 3
        sindrome = 3'b011; datos_recibidos = 7'b1001001; #10; // Caso 4
        sindrome = 3'b111; datos_recibidos = 7'b0111110; #10; // Caso 5

    end

    initial begin
        $dumpfile("module_corrector_error_tb.vcd");
        $dumpvars(0, module_corrector_error_tb);
    end
endmodule
