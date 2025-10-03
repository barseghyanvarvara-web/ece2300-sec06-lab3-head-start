//========================================================================
// DLatch_GL
//========================================================================

`ifndef DLATCH_GL_V
`define DLATCH_GL_V

`include "ece2300/ece2300-misc.v"

// verilator lint_off UNOPTFLAT

module DLatch_GL
(
  (* keep=1 *) input  wire clk,
  (* keep=1 *) input  wire d,
  (* keep=1 *) output wire q
);

  //''' ACTIVITY '''''''''''''''''''''''''''''''''''''''''''''''''''''''''
  // Implement a D Latch using explicit gate-level modeling
  //>'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
  //:
  //: `ECE2300_UNUSED( clk );
  //: `ECE2300_UNUSED( d );
  //: `ECE2300_UNDRIVEN( q );
  //:

  wire s, r, d_b;

  and( s, clk, d );
  not( d_b, d );
  and( r, d_b, clk );

  // SR-Latch
  wire x;
  nor( q, r, x );
  nor( x, q, s );

endmodule

// verilator lint_on UNOPTFLAT

`endif /* DLATCH_GL_V */

