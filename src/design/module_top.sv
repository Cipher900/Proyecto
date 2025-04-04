module module_top (
input logic [3:0] entrada,
input logic [6:0] palabra,
output logic [6:0] siete_seg,
output logic [3:0] led_o,
output logic [6:0] error
);

// Definición de las señales internas
logic [6:0] codificador_out;
logic [6:0] decodificador_in;
logic [2:0] sindrome_c;
logic [2:0] sindrome_d;
logic bit_error_c;
logic bit_error_d;
logic [6:0] palabra_out;

//señales de salida para los led y el display 7 segmentos
logic [3:0] led_cod;
logic [3:0] siete_seg_cod;

// Instancia de los módulos
module_codificador codificador (entrada,codificador_out); // codificador(.sat)
module_detector_error detector_cod(codificador_out,sindrome_c,bit_error_d);
module_corrector_error corrector_cod(sindrome_c,codificador_out,palabra_out);
module_decodificador deco_led(palabra_out,siete_seg_cod);
module_7segmentos display_cod(siete_seg_cod,siete_seg);
module_detector_error detector_deco(palabra,sindrome_d,bit_error_c);
module_corrector_error corrector_deco(sindrome_d,palabra,decodificador_in);
module_decodificador deco_display(decodificador_in,led_cod);
module_led leds(led_cod,led_o);
module_errordisp error_display(bit_error_c,error);

endmodule