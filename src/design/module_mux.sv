module module_mux(
    input logic [6:0] siete_seg,
    input logic [6:0] error,
    input logic swi,
    output logic [6:0] salida_mux
);

assign salida_mux = swi ? error : siete_seg; // Selección entre los dos inputs según el valor de swi
    
endmodule