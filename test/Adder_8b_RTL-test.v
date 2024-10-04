//========================================================================
// Adder_4b_RTL-test
//========================================================================

`include "ece2300-test.v"
`include "Adder_8b_RTL.v"

module Top();

  //----------------------------------------------------------------------
  // Setup
  //----------------------------------------------------------------------

  // verilator lint_off UNUSED
  logic clk;
  logic reset;
  // verilator lint_on UNUSED

  ece2300_TestUtils t( .* );

  //----------------------------------------------------------------------
  // Instantiate design under test
  //----------------------------------------------------------------------

  logic [7:0] dut_in0;
  logic [7:0] dut_in1;
  logic       dut_cin;
  logic       dut_cout;
  logic [7:0] dut_sum;

  Adder_8b_RTL dut
  (
    .in0  (dut_in0),
    .in1  (dut_in1),
    .cin  (dut_cin),
    .cout (dut_cout),
    .sum  (dut_sum)
  );

  //----------------------------------------------------------------------
  // check
  //----------------------------------------------------------------------
  // All tasks start at #1 after the rising edge of the clock. So we
  // write the inputs #1 after the rising edge, and check the outputs #1
  // before the next rising edge.

  task check
  (
    input logic [7:0] in0,
    input logic [7:0] in1,
    input logic       cin,
    input logic       cout,
    input logic [7:0] sum
  );
    if ( !t.failed ) begin

      dut_in0 = in0;
      dut_in1 = in1;
      dut_cin = cin;

      #8;

      if ( t.n != 0 ) begin
        $display( "%3d: %b + %b + %b (%3d + %3d + %b) > %b %b (%3d)", t.cycles,
                  dut_in0, dut_in1, dut_cin,
                  dut_in0, dut_in1, dut_cin,
                  dut_cout, dut_sum, dut_sum );
      end

      `ECE2300_CHECK_EQ( dut_cout, cout );
      `ECE2300_CHECK_EQ( dut_sum,  sum  );

      #2;

    end
  endtask

  //----------------------------------------------------------------------
  // test_case_1_basic
  //----------------------------------------------------------------------

  task test_case_1_basic();
    t.test_case_begin( "test_case_1_basic" );

    //     in0           in1           cin   cout  sum
    check( 8'b0000_0000, 8'b0000_0000, 1'b0, 1'b0, 8'b0000_0000  );
    check( 8'b0000_0001, 8'b0000_0001, 1'b0, 1'b0, 8'b0000_0010 );
    check( 8'b0000_0001, 8'b0000_0001, 1'b1, 1'b0, 8'b0000_0011 );
    check( 8'b1111_1111, 8'b0000_0001, 1'b0, 1'b1, 8'b0000_0000 );
    check( 8'b1111_1111, 8'b1111_1111, 1'b1, 1'b1, 8'b1111_1111 );

  endtask

  //''' ACTIVITy '''''''''''''''''''''''''''''''''''''''''''''''''''''''''
  // Copy your test cases from lab 2
  //>'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

  //----------------------------------------------------------------------
  // main
  //----------------------------------------------------------------------

  initial begin
    t.test_bench_begin( `__FILE__ );

    if ((t.n <= 0) || (t.n == 1)) test_case_1_basic();

    //''' ACTIVITy '''''''''''''''''''''''''''''''''''''''''''''''''''''''
    // Add calls to your test cases here
    //>'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

    t.test_bench_end();
  end

endmodule

