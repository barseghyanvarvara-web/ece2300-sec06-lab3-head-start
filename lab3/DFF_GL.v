//========================================================================
// DFF_GL
//========================================================================

`ifndef DFF_GL_V
`define DFF_GL_V

`include "ece2300/ece2300-misc.v"
`include "lab3/DLatch_GL.v"

module DFF_GL
(
  input  wire clk,
  input  wire d,
  output wire q
);

wire N1, clk_bar;

not(clk_bar, clk);

DLatch_GL followerlatch (

  .clk(clk),
  .d(N1),
  .q(q)

);

DLatch_GL leaderlatch (

  .clk(clk_bar),
  .d(d),
  .q(N1)

);

endmodule

`endif /* DFF_GL_V */
