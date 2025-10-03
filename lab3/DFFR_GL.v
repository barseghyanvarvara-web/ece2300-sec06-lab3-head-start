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

  //''' LAB ASSIGNMENT '''''''''''''''''''''''''''''''''''''''''''''''''''
  // Implement a D flip-flop with reset
  //''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
  // You should instantiate a DFF, then add appropriate logic to
  // implement reset. You _must_ use explict gate-level modeling.
  //:
  //: `ECE2300_UNUSED( clk );
  //: `ECE2300_UNUSED( rst );
  //: `ECE2300_UNUSED( d );
  //: `ECE2300_UNDRIVEN( q );
  //:

  wire rst_b;
  not( rst_b, rst );

  wire d_;
  and( d_, rst_b, d );

  DFF_GL dff
  (
    .clk (clk),
    .d   (d_),
    .q   (q)
  );

  //<'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

endmodule

`endif /* DFFR_GL_V */

