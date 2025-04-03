`timescale 1ns/1ns

module module_top_tb;

reg [3:0] entrada_tb;
reg [6:0] palabra_tb;
wire [6:0] siete_seg_tb;
wire [3:0] led_o_tb;
wire error_tb;

// Instancia del módulo a probar
module_top dut(
    .entrada(entrada_tb),
    .palabra(palabra_tb),
    .siete_seg(siete_seg_tb),
    .led_o(led_o_tb),
    .error(error_tb)
);

// Inicialización de las señales de entrada
initial begin
    // Inicializar las señales de entrada
    entrada_tb = 4'b0000;
    palabra_tb = 7'b0000000;
    $monitor("Tiempo: %0t | Entrada: %b | Palabra: %b | Siete Segmentos: %b | LED: %b | Error: %b", $time, entrada_tb, palabra_tb, siete_seg_tb, led_o_tb, error_tb);
    // Aplicar estímulos al módulo DUT
    #10 entrada_tb = 4'b0001; palabra_tb = 7'b1111110; // Test case 1
    #10 entrada_tb = 4'b0010; palabra_tb = 7'b0110000; // Test case 2
    #10 entrada_tb = 4'b0011; palabra_tb = 7'b1101101; // Test case 3
    #10 entrada_tb = 4'b0100; palabra_tb = 7'b1111001; // Test case 4
    #10 entrada_tb = 4'b0101; palabra_tb = 7'b0110011; // Test case 5
    #10 entrada_tb = 4'b0110; palabra_tb = 7'b1011011; // Test case 6
    #10 entrada_tb = 4'b0111; palabra_tb = 7'b1011111; // Test case 7
    #10 entrada_tb = 4'b1000; palabra_tb = 7'b1110000; // Test case 8
    #10 entrada_tb = 4'b1001; palabra_tb = 7'b1111111; // Test case 9
    
    // Finalizar la simulación después de un tiempo determinado
    #50 $finish;
end
initial begin
    $dumpfile("module_top_tb.vcd");
    $dumpvars(0, module_top_tb);
end

endmodule