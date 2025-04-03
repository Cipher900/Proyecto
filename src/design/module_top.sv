module module_top (
input logic [3:0] entrada,
input logic [6:0] palabra,
output logic [6:0] siete_seg,
output logic [3:0] led_o,
output logic error
);

// Definición de las señales internas
logic [6:0] codificador_out;
logic [3:0] decodificador_out;
logic [2:0] sindrome_c;
logic [2:0] sindrome_d;
logic bit_error_c;
logic bit_error_d;
logic [6:0] corrector_c_out;
logic [6:0] corrector_deco_out;

//señales de salida para los led y el display 7 segmentos
logic [3:0] led_cod='0;
logic [6:0] siete_seg_deco='0;
// Instancia de los módulos
module_codificador codificador (entrada,codificador_out);
module_decodificador decodificador(palabra,decodificador_out);
module_detector_error detector_dec(decodificador_out,sindrome_d,bit_error_d);
module_corrector_error corrector_deco(sindrome_d,decodificador_out,siete_seg_deco);
module_decodificador deco_led();

endmodule