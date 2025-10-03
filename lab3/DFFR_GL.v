//========================================================================
// DFFR_GL
//========================================================================

`ifndef DFFR_GL_V
`define DFFR_GL_V

`include "lab3/DFF_GL.v"

module DFFR_GL
(
  (* keep=1 *) input  wire clk,
  (* keep=1 *) input  wire rst,
  (* keep=1 *) input  wire d,
  (* keep=1 *) output wire q
);

  wire rst_bar, anded;

  not(rst_bar, rst);
  and(anded, rst_bar, d);

  DFF_GL flipflop (

    .clk(clk),
    .d(anded),
    .q(q)

  );

endmodule

`endif /* DFFR_GL_V */
