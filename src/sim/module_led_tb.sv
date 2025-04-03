`timescale 1ns/1ns

module module_led_tb;

    // Definición de las señales de prueba
    reg [3:0] led_in; // Entrada de 4 bits
    wire [3:0] led_out; // Salida de 4 bits

    // Instancia del módulo a probar
    module_led dut (
        .in(led_in),
        .out(led_out)
    );

// Generación de estímulos
    initial begin
        $display("-------|---------|--------");
        $display("Tiempo | Entrada | Salida ");
        $display("-------|---------|--------");

        // Monitoreo de las señales
        $monitor("Tiempo = %t, Entrada = %b, Salida = %b", $time , led_in, led_out);
    
        // Estímulos de prueba
        led_in = 4'b0000; #10; // Caso 0
        led_in = 4'b0001; #10; // Caso 1
        led_in = 4'b0010; #10; // Caso 2
        led_in = 4'b0011; #10; // Caso 3
        led_in = 4'b0100; #10; // Caso 4
        led_in = 4'b0101; #10; // Caso 5
        led_in = 4'b0110; #10; // Caso 6
        led_in = 4'b0111; #10; // Caso 7
        led_in = 4'b1000; #10; // Caso 8
        led_in = 4'b1001; #10; // Caso 9
        led_in = 4'b1010; #10; // Caso A
        led_in = 4'b1011; #10; // Caso B
        led_in = 4'b1100; #10; // Caso C
        led_in = 4'b1101; #10; // Caso D
        led_in = 4'b1110; #10; // Caso E
        led_in = 4'b1111; #10; // Caso F
    end 

    initial begin
        $dumpfile("module_led_tb.vcd");
        $dumpvars(0, module_led_tb);
    end
endmodule