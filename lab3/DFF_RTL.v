//========================================================================
// DFF_RTL
//========================================================================

`ifndef DFF_RTL_V
`define DFF_RTL_V

module DFF_RTL
(
  (* keep=1 *) input  logic clk,
  (* keep=1 *) input  logic d,
  (* keep=1 *) output logic q
);

  //''' LAB ASSIGNMENT '''''''''''''''''''''''''''''''''''''''''''''''''''
  // Implement a single-bit D flip-flop using RTL
  //''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
  // You _must_ use a single always_ff block for you RTL modeling. You
  // cannot use any explicit gate-level modeling.
  //:
  //: `ECE2300_UNUSED( clk );
  //: `ECE2300_UNUSED( d );
  //: `ECE2300_UNDRIVEN( q );
  //:

  always_ff @( posedge clk ) begin
    q <= d;
  end

endmodule

`endif /* DFF_RTL_V */

