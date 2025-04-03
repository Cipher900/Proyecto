`timescale 1ns/1ns

module module_errordisp_tb;

reg bit_error_tb;
wire[6:0] disp_error_tb;

// Instancia del módulo a probar
module_errordisp dut(
    .bit_error(bit_error_tb),
    .disp_error(disp_error_tb)
);

initial begin

    // Inicializar las señales de entrada
    $monitor("Tiempo: %0t | Bit Error: %b | Display Error: %b", $time, bit_error_tb, disp_error_tb);
    
    // Aplicar estímulos al módulo DUT
    #50 bit_error_tb = 1'b1; // Test case 1 (Error)
    #50 bit_error_tb = 1'b0; // Test case 2 (No Error)
    
    // Finalizar la simulación después de un tiempo determinado
    #100 $finish;

end
initial begin
    $dumpfile("module_errordisp_tb.vcd");
    $dumpvars(0, module_errordisp_tb);
end
endmodule
