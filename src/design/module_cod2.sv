module cod2(
    input logic [3:0] data,
    output logic [6:0] data_paridad,
);

logic p1,p2,p3; // Bits de paridad
assign p1 = (data[0] ^ data[1] ^ data[3]); // p1 cubre la paridad de los bits de data 0,1,3

assign p2 = (data[0] ^ data[2] ^ data[3]); // p2 cubre la paridad de los bits de data 0,2,3

assign p3 = (data[1] ^ data[2] ^ data[3]); // p3 cubre la paridad de los bits 1,2,3

assign data_paridad = {data[3], data[2], data[1], p3, data[0], p2, p3};
endmodule