`timescale 1ns/1ns

module module_mux_tb;

reg [6:0] siete_seg_tb;
reg [6:0] error_tb;
reg swi_tb;
wire [6:0] salida_mux_tb;

// Instancia del módulo a probar
module_mux dut(
    .siete_seg(siete_seg_tb),
    .error(error_tb),
    .swi(swi_tb),
    .salida_mux(salida_mux_tb)
);

// Inicialización de las señales de entrada
initial begin
    $monitor("Tiempo: %0t | Siete Segmentos: %b | Error: %b | Switch: %b | Salida Mux: %b", $time, siete_seg_tb, error_tb, swi_tb, salida_mux_tb);
    // Inicializar las señales de entrada
    siete_seg_tb = 7'b0000000;
    error_tb = 7'b1111111;
    swi_tb = 0; // Selección inicial

    // Aplicar estímulos al módulo DUT
    #50 siete_seg_tb = 7'b1010101; error_tb = 7'b1100110; swi_tb = 0; // Caso normal
    #50 siete_seg_tb = 7'b1010101; error_tb = 7'b1100110; swi_tb = 1; // Caso de error
    #50 siete_seg_tb = 7'b1111111; error_tb = 7'b0000000; swi_tb = 0; // Caso normal
    #50 siete_seg_tb = 7'b1111111; error_tb = 7'b0000000; swi_tb = 1; // Caso de error
    
    // Finalizar la simulación después de un tiempo determinado
    #100 $finish;
end

initial begin
    $dumpfile("module_mux_tb.vcd");
    $dumpvars(0, module_mux_tb);
end

endmodule