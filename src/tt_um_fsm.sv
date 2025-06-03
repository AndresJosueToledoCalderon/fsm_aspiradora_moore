//`timescale 100ns / 1ps

module tt_um_fsm (

  input logic clk,
  input logic rst_n,
  input logic ena,
  input logic [7:0] ui_in,
  input logic [7:0] uio_in,
  output logic [7:0] uo_out,
  output logic [7:0] uio_out,
  output logic [7:0] uio_oe
    // SW0=power_off, SW1=on, SW2=cleaning, SW3=evading
    // led0 y led1 muestran el estado actual
);

    // renombramos para claridad
    // solo les damos nombres a cada i del array de los switches
    wire power_off  = ui_in[0];
    wire on         = ui_in[1];
    wire cleaning   = ui_in[2];
    wire evading    = ui_in[3];

    logic [1:0] state;
    logic [1:0] led;

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
    assign led = state;
    assign uo_out[1:0] = led;
    assign uo_out[7:2] = 5'b0;
    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;
    wire _unused_ok = &{
          1'b0,
          rst_n,
          ena,
          ui_in[7:4],
          uio_in,
          1'b0
      };
endmodule
