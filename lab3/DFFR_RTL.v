//========================================================================
// DFFR_RTL
//========================================================================

`ifndef DFFR_RTL_V
`define DFFR_RTL_V

`include "ece2300/ece2300-misc.v"

module DFFR_RTL
(
  (* keep=1 *) input  logic clk,
  (* keep=1 *) input  logic rst,
  (* keep=1 *) input  logic d,
  (* keep=1 *) output logic q
);

  //''' LAB ASSIGNMENT '''''''''''''''''''''''''''''''''''''''''''''''''''
  // Implement a D flip-flop with reset using RTL
  //''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
  // You _must_ use a single always_ff block for you RTL modeling. You
  // cannot use any explicit gate-level modeling.

  always_ff @( posedge clk ) begin

    if ( rst )
      q <= 0;
    else
      q <= d;

    // explicit xprop

    `ECE2300_SEQ_XPROP( q, $isunknown(rst) );

  end

endmodule

`endif /* DFFR_RTL_V */

