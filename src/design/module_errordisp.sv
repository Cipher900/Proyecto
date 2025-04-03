module module_errordisp(
    input logic bit_error,
    output logic[6:0] disp_error
);
    // Asignación del error al display de 7 segmentos
    assign disp_error = (bit_error == 1'b1) ? 7'b011_0000 :
                        (bit_error == 1'b0) ? 7'b111_1110 :
                        7'bxxx_xxxx;
endmodule