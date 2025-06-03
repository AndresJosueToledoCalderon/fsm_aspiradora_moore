`timescale 100ns / 1ps

module tt_um_fsm (

  input wire clk,
  input wire rst_n,
  input wire ena,
  input wire [7:0] ui_in,
  input wire [7:0] uio_in,
  output wire [7:0] uo_out,
  output wire [7:0] uio_out,
  output wire [7:0] uio_oe
    // SW0=power_off, SW1=on, SW2=cleaning, SW3=evading
    // led0 y led1 muestran el estado actual
);

    // renombramos para claridad
    // solo les damos nombres a cada i del array de los switches
    wire power_off  = ui_in[0];
    wire on         = ui_in[1];
    wire cleaning   = ui_in[2];
    wire evading    = ui_in[3];

    

    // instanciamos la fsm (las "opoeraciones"), y exponemos solo state
    FSM_Aspiradora aspiradora (
        .clk        (clk),
        .power_off  (power_off),
        .on         (on),
        .cleaning   (cleaning),
        .evading    (evading),
        .state_0    (state)
    );

    // conectamos los leds 0 y 1 con el estado en que se encuentran
    assign led = uo_out[1:0];
    assign ui_in[7:4] = 4'b0;
    assign uo_out[7:3] = 5'b0;
    assign uio_out = 8'b0;
    assign uio_oe = 8'b0;
    assign uio_in = 8'b0;
    assign ena = 1'b0:
    assign rst_n = 1'b0;
    
endmodule
