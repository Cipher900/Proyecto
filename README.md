# Detalles del proyecto
**Tarea 1:** Introducción al diseño digital en HDL 
**Integrantes del proyecto:** Felipe Sánchez Segura y Gabriel Morgan Ovares

Este proyecto tuvo como objetivo introducir herramientas útiles en el área de la electrónica e ingeniería en general, como lo es el lenguaje de descripción de hardware (HDL) y su implementación física utilizando una FPGA para el diseño de sistemas digitales. 
## 1. Desarrollo
En la siguiente sección se presentan los diseños, diagramas y módulos desarrollados a lo largo de la elaboración del sistema propuesto en el proyecto. 
### 1.0 Descripción general del sistema
El presente sistema consiste en un circuito orientado a la recuperación de información, implementado mediante el algoritmo de Hamming, utilizando lógica combinacional en SystemVerilog. El sistema opera a partir de dos entradas: una palabra de referencia y una palabra a transmitir.

A través del algoritmo de Hamming, el sistema verifica la existencia de errores en la palabra transmitida. En caso de detectarse un error, este es corregido automáticamente, y la palabra corregida es decodificada para su posterior visualización en un display de siete segmentos. De manera simultánea, la palabra de referencia se despliega en los LEDs de la FPGA, permitiendo una comparación visual entre ambas.

Para su desarrollo, el sistema ha sido estructurado en distintos **subsistemas funcionales**, con el fin de modularizar su diseño y facilitar su implementación. De manera general, se distinguen dos subsistemas principales:

1. **Subsistema de procesamiento**: Responsable de la codificación, verificación, corrección y decodificación de las palabras, utilizando el algoritmo de Hamming.

2. **Subsistema de visualización**: Encargado del despliegue de la información procesada en los distintos elementos de salida (display de siete segmentos y LEDs).

A continuación se presenta un diagrama de la conexión de los subsistemas:
### 1.1 Módulos
A continuación, se presenta la descripción de los principales módulos que componen el sistema desarrollado.
##### Módulo Top
En este módulo se instancian los múltiples módulos que fueron desarrollados para este proyecto. Se conectan de manera que cumpla con lo estipulado en los diagramas anteriores.

```SystemVerilog
module module_top (
input logic [3:0] entrada, // Palabra de referencia
input logic [6:0] palabra, // Palabra a transmitir
output logic [6:0] siete_seg,
output logic [3:0] led_o,
output logic [6:0] error
);

// Definición de las señales internas
logic [6:0] codificador_out;
logic [6:0] decodificador_in;
logic [2:0] sindrome_c;
logic [2:0] sindrome_d;
logic bit_error_c;
logic bit_error_d;
logic [6:0] palabra_out;

//señales de salida para los led y el display 7 segmentos
logic [3:0] led_cod;
logic [3:0] siete_seg_cod;

// Instancia de los módulos
module_codificador codificador (entrada,codificador_out);
module_detector_error detector_cod(codificador_out,sindrome_c,bit_error_d);
module_corrector_error corrector_cod(sindrome_c,codificador_out,palabra_out);
module_decodificador deco_led(palabra_out,siete_seg_cod);
module_7segmentos display_cod(siete_seg_cod,siete_seg);
module_detector_error detector_deco(palabra,sindrome_d,bit_error_c);
module_corrector_error corrector_deco(sindrome_d,palabra,decodificador_in);
module_decodificador deco_display(decodificador_in,led_cod);
module_led leds(led_cod,led_o);
module_errordisp error_display(bit_error_c,error);

endmodule
```
#### 1.2 Entradas y salidas:
- `entrada_i`: descripción de la entrada
- `salida_o`: descripción de la salida

#### 1.4 Testbench
Descripción y resultados de las pruebas hechas

Testbench top
```SystemVerilog
`timescale 1ns/1ns

module module_top_tb;

reg [3:0] entrada_tb;
reg [6:0] palabra_tb;
wire [6:0] siete_seg_tb;
wire [3:0] led_o_tb;
wire [6:0] error_tb;

// Instancia del módulo a probar
module_top dut(
    .entrada(entrada_tb),
    .palabra(palabra_tb),
    .siete_seg(siete_seg_tb),
    .led_o(led_o_tb),
    .error(error_tb)
);

// Inicialización de las señales de entrada
initial begin
    // Inicializar las señales de entrada
    entrada_tb = 4'b0000;
    palabra_tb = 7'b0000000;
    $monitor("Tiempo: %0t | Entrada: %b | Palabra: %b | Siete Segmentos: %b | LED: %b | Error: %b", $time, entrada_tb, palabra_tb, siete_seg_tb, led_o_tb, error_tb);
    // Aplicar estímulos al módulo DUT
    #50 entrada_tb = 4'b0001; palabra_tb = 7'b0000111; // Test case 1
    #50 entrada_tb = 4'b0010; palabra_tb = 7'b0010001; // Test case 2
    #50 entrada_tb = 4'b0011; palabra_tb = 7'b0011110; // Test case 3
    #50 entrada_tb = 4'b0100; palabra_tb = 7'b0101010; // Test case 4
    #50 entrada_tb = 4'b0101; palabra_tb = 7'b0101100; // Test case 5
    #50 entrada_tb = 4'b0110; palabra_tb = 7'b1011011; // Test case 6
    #50 entrada_tb = 4'b0111; palabra_tb = 7'b0110100; // Test case 7
    #50 entrada_tb = 4'b1000; palabra_tb = 7'b0001011; // Test case 8
    #50 entrada_tb = 4'b1001; palabra_tb = 7'b1111111; // Test case 9
    
    // Finalizar la simulación después de un tiempo determinado
    #100 $finish;
end
initial begin
    $dumpfile("module_top_tb.vcd");
    $dumpvars(0, module_top_tb);
end

endmodule
```
Con este módulo se encontaron los valores: 

![image](https://github.com/user-attachments/assets/dbb19976-bf16-4b90-8698-a297b0e850fb)

#### 1.5 Otros Modulos 
- agregar informacion siguiendo el ejemplo anterior.

##### Módulo Mux
```SystemVerilog
module module_mux(
    input logic [6:0] siete_seg,
    input logic [6:0] error,
    input logic swi,
    output logic [6:0] salida_mux
);

assign salida_mux = swi ? error : siete_seg; // Selección entre los dos inputs según el valor de swi
    
endmodule
```
##### Módulo Corrector de error

```SystemVerilog
module module_corrector_error(
    input  logic[2:0] sindrome,        // Entrada de 3 bits [p2,p1,p0]. Síndrome de error.
    input  logic[6:0] datos_recibidos,  // Entrada de 7 bits [i3,i2,i1,c2,i0,c1,c0].
    output logic[6:0] data             // Salida de 7 bits [i3,i2,i1,c2,i0,c1,c0].  
);

assign data = (sindrome == 3'b000) ? datos_recibidos : //No hay error 
              (sindrome == 3'b001) ? {datos_recibidos[6:1], ~datos_recibidos[0]} : //Error en bit 0
              (sindrome == 3'b010) ? {datos_recibidos[6:2], ~datos_recibidos[1], datos_recibidos[0]} : //Error en bit 1
              (sindrome == 3'b011) ? {datos_recibidos[6:3], ~datos_recibidos[2], datos_recibidos[1:0]} : //Error en bit 2
              (sindrome == 3'b100) ? {datos_recibidos[6:4], ~datos_recibidos[3], datos_recibidos[2:0]} : //Error en bit 3
              (sindrome == 3'b101) ? {datos_recibidos[6:5], ~datos_recibidos[4], datos_recibidos[3:0]} : //Error en bit 4
              (sindrome == 3'b110) ? {~datos_recibidos[6], datos_recibidos[5:0]} : //Error en bit 5
              (sindrome == 3'b111) ? {~datos_recibidos[6],datos_recibidos[5:0]} : //Error en bit 6
              7'bxxxxxxxx;
endmodule
```
##### Módulo Codificador

```SystemVerilog
module module_codificador (input logic [3:0] datos_in, //Entrada de 4 bits [3,2,1,0]
                           output logic [6:0] datos_cod); //Salida de 7 bits [7,6,5,4,3,2,1,0]

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
```
##### Módulo Decodificador

```SystemVerilog
module module_decodificador ( // Modulo decodificador de una palabra de 7 bits. Segunda parte del código de hamming 3
    input logic [6:0] datos_cod,     //Entrada de 7 bits [i3,i2,i1,c2,i0,c1,c0]
    output logic [3:0] datos_out      //Salida de 4 bits [i3,i2,i1,i0]
); 

assign datos_out[0] = datos_cod[2]; // i0
assign datos_out[1] = datos_cod[4]; // i1
assign datos_out[2] = datos_cod[5]; // i2
assign datos_out[3] = datos_cod[6]; // i3

endmodule
```
##### Módulo 7 Segmentos

```SystemVerilog
module module_7segmentos(
    input  logic[3:0] data,            // Entrada de 4 bits [d3,d2,d1,d0]. 
    output logic[6:0] display          // Salida de 7 bits [a,b,c,d,e,f,g]. 
);
// Decodificador 4 a 7 de 7bits.        gfe dcba      // Valores para guardar el valor de cada segmento.
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
```
##### Módulo Detector de Error

```SystemVerilog
module module_detector_error( // Modulo detector de error de una palabra de 7 bits.
    input  logic [6:0] datos_recibidos,  //Entrada de 7 bits [i3,i2,i1,c2,i0,c1,c0]
    output logic [2:0] sindrome,         // Salida de 3 bits [p2,p1,p0]. Síndrome de error 
    output logic       bit_error        // Salida del bit del error.
);
// Calculo del síndrome del error en la palabra recibida.
assign sindrome[0] = datos_recibidos[0]^datos_recibidos[2]^datos_recibidos[4]^datos_recibidos[6]; // p0 = c0^i0^i1^i3
assign sindrome[1] = datos_recibidos[1]^datos_recibidos[2]^datos_recibidos[5]^datos_recibidos[6]; // p1 = c1^i0^i2^i3
assign sindrome[2] = datos_recibidos[3]^datos_recibidos[4]^datos_recibidos[5]^datos_recibidos[6]; // p2 = c2^i1^i2^i3
// Se trabaja con la función XOR para calcular los bits de paridad.

assign bit_error = sindrome[0] | sindrome[1] | sindrome[2]; 
// Se trabaja con la funcion OR para encontrar el bit erroneo.
endmodule
```
##### Módulo Error Display

```SystemVerilog
module module_errordisp(
    input logic bit_error,
    output logic[6:0] disp_error
);
    // Asignación del error al display de 7 segmentos
    assign disp_error = (bit_error == 1'b1) ? 7'b011_0000 :
                        (bit_error == 1'b0) ? 7'b111_1110 :
                        7'bxxx_xxxx;
endmodule
```
##### Módulo LED

```SystemVerilog
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
```
## 2. Consumo de recursos

``` markdown
=== module_top ===
   Number of wires:                 78
   Number of wire bits:            210
   Number of public wires:          78
   Number of public wire bits:     210
   Number of memories:               0
   Number of memory bits:            0
   Number of processes:              0
   Number of cells:                 91
     GND                             1
     IBUF                           11
     LUT1                            1
     LUT4                           35
     MUX2_LUT5                      14
     MUX2_LUT6                       7
     MUX2_LUT7                       3
     OBUF                           18
     VCC                             1
```
## 3. Problemas encontrados durante el proyecto
Los problemas encontrados con el proyecto fueron:
-`Pasar de la simulación a la fpga y el circuito fisíco.` \n
-`El código del corrector error fue retador.` \n
-`El código del 7 segmentos.` \n
## 4. Abreviaturas y definiciones
**FPGA:** Field Programmable Gate Arrays
**HDL:** Hardware Description Language
**LED:** Light Emitting Diode
## 5. Referencias
[0] David Harris y Sarah Harris. *Digital Design and Computer Architecture. RISC-V Edition.* Morgan Kaufmann, 2022. ISBN: 978-0-12-820064-3
