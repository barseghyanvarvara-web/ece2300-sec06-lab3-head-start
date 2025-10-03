//========================================================================
// Mux2_1b_GL
//========================================================================

`ifndef MUX2_1B_GL
`define MUX2_1B_GL

`include "ece2300/ece2300-misc.v"

module Mux2_1b_GL
(
  (* keep=1 *) input  in0,
  (* keep=1 *) input  in1,
  (* keep=1 *) input  sel,
  (* keep=1 *) output out
);

  wire sel_bar; // not for input sel

  not(sel_bar, sel);

  wire m1, m2; 

  and(m1, sel_bar, in0);
  and(m2, sel,     in1);

  or(out, m1, m2);

endmodule

`endif /* MUX2_1B_GL */
