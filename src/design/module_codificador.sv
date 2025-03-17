module codificador (
    // Modulo codificador de una palabra de 4 bits. Primera parte del codigo de hamming.
    input [3:0] in,      //Entrada de 4 bits [3,2,1,0]
    output [6:0] out,     //Salida de 7 bits [7,6,5,4,3,2,1,0]
);
logic p1,p2,p3; // Bits de paridad
assign p1 = in[0]^in[1]^in[3]; // p1 cubre la paridad de los bits 1,2,4
assign p2 = in[0]^in[2]^in[3]; // p2 cubre la paridad de los bits 1,3,4
assign p3 = in[1]^in[2]^in[3]; // p3 cubre la paridad de los bits 2,3,4

assign out = {p1, p2, in[3], p3, in[2], in[1], in[0]}; // Salida de 7 bits. Palabra codificada.
endmodule