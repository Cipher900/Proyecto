module corrector_error(
    input  logic [2:0] sindrome;         // Salida de 3 bits [p2,p1,p0]. Síndrome de error
    input  logic [6:0] datos_recibidos;  //Entrada de 7 bits [i3,i2,i1,c2,i0,c1,c0]
    output logic [6:0] data;     
)
// Decodificador 3 a 8 de 8bits.
logic  [7:0]    d0, d1, d2, d3, d4, d5, d6, d7;
assign d0[0] = ~sindrome[0]  & ~sindrome[1]  & ~sindrome[2];
assign d1[1] = ~sindrome[0]  & ~sindrome[1]  &  sindrome[2];
assign d2[2] = ~sindrome[0]  &  sindrome[1]  & ~sindrome[2];
assign d3[3] = ~sindrome[0]  &  sindrome[1]  &  sindrome[2];
assign d4[4] =  sindrome[0]  & ~sindrome[1]  & ~sindrome[2];
assign d5[5] =  sindrome[0]  & ~sindrome[1]  &  sindrome[2];
assign d6[6] =  sindrome[0]  &  sindrome[1]  & ~sindrome[2];
assign d7[7] =  sindrome[0]  &  sindrome[1]  &  sindrome[2];

// Mux 8 a 1 de 8bits.

endmodule