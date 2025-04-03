module module_led(
    input logic [3:0] in,
    output logic [3:0] out
);

    // Asignación de los LEDs a los bits de entrada
    assign out[0] = ~in[0]; // LED 0
    assign out[1] = ~in[1]; // LED 1
    assign out[2] = ~in[2]; // LED 2
    assign out[3] = ~in[3]; // LED 3
endmodule