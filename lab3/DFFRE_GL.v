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

  //''' LAB ASSIGNMENT '''''''''''''''''''''''''''''''''''''''''''''''''''
  // Implement a D enabled & resettable flip-flop using DFF and mux. You
  // can also use a DFFR and a mux if you like.
  //''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

  `ECE2300_UNUSED( clk );
  `ECE2300_UNUSED( rst );
  `ECE2300_UNUSED( en );
  `ECE2300_UNUSED( d );
  `ECE2300_UNDRIVEN( q );

endmodule

// verilator lint_on UNOPTFLAT

`endif /* DFFRE_GL_V */
