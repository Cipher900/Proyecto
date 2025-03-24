module detector_error( // Modulo detector de error de una palabra de 7 bits.
    input logic [6:0] datos_recibidos //Entrada de 7 bits [i3,i2,i1,c2,i0,c1,c0]
    output logic [2:0] sindrome // Salida de 3 bits [p2,p1,p0]. Síndrome de error 
);
// Calculo del síndrome del error en la palabra recibida.
assign sindrome[0] = datos_recibidos[0]^datos_recibidos[2]^datos_recibidos[4]^datos_recibidos[6]; // p0 = c0^i0^i1^i3
assign sindrome[1] = datos_recibidos[1]^datos_recibidos[2]^datos_recibidos[5]^datos_recibidos[6]; // p1 = c1^i0^i2^i3
assign sindrome[2] = datos_recibidos[3]^datos_recibidos[4]^datos_recibidos[5]^datos_recibidos[6]; // p2 = c2^i1^i2^i3
// Se trabaja con la función XOR para calcular los bits de paridad.
endmodule