module codificador ( // Modulo codificador de una palabra de 4 bits. Primera parte del codigo de hamming 3.
    input logic [3:0] datos_in,      //Entrada de 4 bits [3,2,1,0]
    output logic [6:0] datos_cod,     //Salida de 7 bits [7,6,5,4,3,2,1,0]
);

assign datos_cod[2] = datos_in[0]; // i0
assign datos_cod[4] = datos_in[1]; // i1
assign datos_cod[5] = datos_in[2]; // i2
assign datos_cod[6] = datos_in[3]; // i3

// bits de paridad
assign datos_cod[0] = datos_in[0]^datos_in[1]^datos_in[3]; // c0 cubre la paridad de los bits 1,2,4 
assign datos_cod[1] = datos_in[0]^datos_in[2]^datos_in[3]; // c1 cubre la paridad de los bits 1,3,4
assign datos_cod[3] = datos_in[1]^datos_in[2]^datos_in[3]; // c2 cubre la paridad de los bits 2,3,4
// Se trabaja con la función XOR para calcular los bits de paridad.
endmodule