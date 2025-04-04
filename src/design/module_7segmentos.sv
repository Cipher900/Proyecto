module module_7segmentos(
    input  logic[3:0] data,            // Entrada de 4 bits [d3,d2,d1,d0]. 
    output logic[6:0] display          // Salida de 7 bits [a,b,c,d,e,f,g]. 
);
// Decodificador 4 a 7 de 7bits.        abc defg    // Valores para guardar el valor de cada segmento.
assign display = (data == 4'b0000) ? 7'b111_1110:
                 (data == 4'b0001) ? 7'b011_0000:
                 (data == 4'b0010) ? 7'b110_1101:
                 (data == 4'b0011) ? 7'b111_1001:
                 (data == 4'b0100) ? 7'b011_0011:
                 (data == 4'b0101) ? 7'b101_1011:
                 (data == 4'b0110) ? 7'b101_1111:
                 (data == 4'b0111) ? 7'b111_0000:
                 (data == 4'b1000) ? 7'b111_1111:
                 (data == 4'b1001) ? 7'b111_0011:
                 7'bxxx_xxxx; // Default case, all segments off
endmodule