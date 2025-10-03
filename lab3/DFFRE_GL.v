//========================================================================
// DFFRE_GL
//========================================================================

`ifndef DFFRE_GL_V
`define DFFRE_GL_V

`include "ece2300/ece2300-misc.v"

`include "lab2/Mux2_1b_GL.v"
`include "lab3/DFF_GL.v"
`include "lab3/DFFR_GL.v"

// verilator lint_off UNOPTFLAT

module DFFRE_GL
(
  (* keep=1 *) input  wire clk,
  (* keep=1 *) input  wire rst,
  (* keep=1 *) input  wire en,
  (* keep=1 *) input  wire d,
  (* keep=1 *) output wire q
);

  wire rst_bar, mux_in, d_in;

  not(rst_bar, rst);
  and(d_in, rst_bar, mux_in);

  Mux2_1b_GL mux(

  .in0  (d),
  .in1  (q),
  .sel  (en),
  .out  (mux_in)
     
  );

  DFF_GL flipflop (

    .clk(clk),
    .d(d_in),
    .q(q)

  );

endmodule

// verilator lint_on UNOPTFLAT

`endif /* DFFRE_GL_V */
