//========================================================================
// DFFRE_RTL_V
//========================================================================

`ifndef DFFRE_RTL_V
`define DFFRE_RTL_V

`include "ece2300/ece2300-misc.v"

module DFFRE_RTL
(
  (* keep=1 *) input  logic clk,
  (* keep=1 *) input  logic rst,
  (* keep=1 *) input  logic en,
  (* keep=1 *) input  logic d,
  (* keep=1 *) output logic q
);

  //''' LAB ASSIGNMENT '''''''''''''''''''''''''''''''''''''''''''''''''''
  // Implement a D flip-flop with reset and enable using RTL
  //''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
  // You _must_ use a single always_ff block for you RTL modeling. You
  // cannot use any explicit gate-level modeling.

  `ECE2300_UNUSED( clk );
  `ECE2300_UNUSED( rst );
  `ECE2300_UNUSED( en );
  `ECE2300_UNUSED( d );
  `ECE2300_UNDRIVEN( q );

endmodule

`endif /* DFFRE_RTL_V */

