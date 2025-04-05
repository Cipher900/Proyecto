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
Con este módulo se encontaron los valores: 
![image](https://github.com/user-attachments/assets/dbb19976-bf16-4b90-8698-a297b0e850fb)


#### 1.5 Otros modulos
- agregar informacion siguiendo el ejemplo anterior.


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

## 4. Abreviaturas y definiciones
**FPGA:** Field Programmable Gate Arrays
**HDL:** Hardware Description Language
**LED:** Light Emitting Diode
## 5. Referencias
[0] David Harris y Sarah Harris. *Digital Design and Computer Architecture. RISC-V Edition.* Morgan Kaufmann, 2022. ISBN: 978-0-12-820064-3
