//========================================================================
// SimpleCounter_8b_RTL
//========================================================================

`ifndef SIMPLE_COUNTER_8B_RTL_V
`define SIMPLE_COUNTER_8B_RTL_V

`include "Adder_8b_RTL.v"
`include "Register_RTL.v"

module SimpleCounter_8b_RTL
(
  input  wire       clk,
  input  wire       rst,
  output wire [7:0] count
);

  //''' LAB ASSIGNMENT '''''''''''''''''''''''''''''''''''''''''''''''''''
  // Implement a gate-level simple counter that counts up by one
  //>'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

endmodule

`endif /* SIMPLE_COUNTER_8B_RTL_V */

