module module_corrector_error(
    input  logic[2:0] sindrome,        // Entrada de 3 bits [p2,p1,p0]. Síndrome de error.
    input  logic[6:0] datos_recibidos,  // Entrada de 7 bits [i3,i2,i1,c2,i0,c1,c0].
    output logic[6:0] data             // Salida de 7 bits [i3,i2,i1,c2,i0,c1,c0].  
);
// Decodificador 3 a 8 de 8bits.                     // Valores para guardar posicion de bit erroneo.
logic [7:0] data8;   
 
assign data8[7] = &{~sindrome[0], ~sindrome[1], ~sindrome[2]};     // Valor si el bit erroneo es bit 0.
assign data8[6] = &{~sindrome[0], ~sindrome[1],  sindrome[2]};     // Valor si el bit erroneo es bit 1.
assign data8[5] = &{~sindrome[0], sindrome[1], ~sindrome[2]};      // Valor si el bit erroneo es bit 2.
assign data8[4] = &{~sindrome[0], sindrome[1],  sindrome[2]};      // Valor si el bit erroneo es bit 3.
assign data8[3] = &{sindrome[0], ~sindrome[1], ~sindrome[2]};      // Valor si el bit erroneo es bit 4.
assign data8[2] = &{sindrome[0], ~sindrome[1],  sindrome[2]};      // Valor si el bit erroneo es bit 5.
assign data8[1] = &{sindrome[0],  sindrome[1], ~sindrome[2]};      // Valor si el bit erroneo es bit 6.
assign data8[0] = &{sindrome[0],  sindrome[1],  sindrome[2]};      // Valor si el bit erroneo no existe. 

// Calculo de data.                                                 
assign data  = datos_recibidos ^ data8[7:1];                   // Funcion XOR para cambiar el bit erroneo a su real valor.           
// Data es los primeros 7 bits de derecha a izquierda de data8 ya que data8 es de 8 bits.

endmodule
