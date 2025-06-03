`timescale 100ns / 1ps

module top_fsm_aspiradora (
    input  wire CLK100MHZ,   // reloj a 100 MHz
    input  wire [3:0] SW,    // SW0=power_off, SW1=on, SW2=cleaning, SW3=evading
    output wire [1:0] led    // led0 y led1 muestran el estado actual
);

    // renombramos para claridad
    // solo les damos nombres a cada i del array de los switches
    wire power_off  = SW[0];
    wire on         = SW[1];
    wire cleaning   = SW[2];
    wire evading    = SW[3];

    // conexion, canal, para ver el estado de la
    // aspiradora
    logic [1:0] state;

    // instanciamos la fsm (las "opoeraciones"), y exponemos solo state
    FSM_Aspiradora (
        .clk        (CLK100MHZ),
        .power_off  (power_off),
        .on         (on),
        .cleaning   (cleaning),
        .evading    (evading),
        .state_0    (state)
    );

    // conectamos los leds 0 y 1 con el estado en que se encuentran
    assign led = state;
endmodule