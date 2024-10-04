//========================================================================
// Register_RTL
//========================================================================

`ifndef REGISTER_RTL_V
`define REGISTER_RTL_V

module Register_RTL
#(
  parameter p_nbits = 1
)(
  input  logic               clk,
  input  logic               rst,
  input  logic               en,
  input  logic [p_nbits-1:0] d,
  output logic [p_nbits-1:0] q
);

  //''' LAB ASSIGNMENT '''''''''''''''''''''''''''''''''''''''''''''''''''
  // Implement a parameterized register-transfer-level register
  //>'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

endmodule

`endif /* REGISTER_RTL_V */

