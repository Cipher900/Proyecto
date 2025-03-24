module decodificador ( // Modulo decodificador de una palabra de 7 bits. Segunda parte del código de hamming 3
    input logic [6:0] datos_cod,     //Entrada de 7 bits [i3,i2,i1,c2,i0,c1,c0]
    output logic [3:0] datos_out      //Salida de 4 bits [i3,i2,i1,i0]
); 

assign datos_out[0] = datos_cod[2]; // i0
assign datos_out[1] = datos_cod[4]; // i1
assign datos_out[2] = datos_cod[5]; // i2
assign datos_out[3] = datos_cod[6]; // i3

endmodule