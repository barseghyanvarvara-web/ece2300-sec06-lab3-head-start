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

  //''' LAB ASSIGNMENT '''''''''''''''''''''''''''''''''''''''''''''''''''
  // Implement a single-bit D flip-flop using a D Latch
  //''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
  //:
  //: `ECE2300_UNUSED( clk );
  //: `ECE2300_UNUSED( d );
  //: `ECE2300_UNDRIVEN( q );
  //:

  wire clk_b;
  not( clk_b, clk );

  wire leader_q;

  DLatch_GL leader
  (
    .clk (clk_b),
    .d   (d),
    .q   (leader_q)
  );

  DLatch_GL follower
  (
    .clk (clk),
    .d   (leader_q),
    .q   (q)
  );

endmodule

`endif /* DFF_GL_V */

