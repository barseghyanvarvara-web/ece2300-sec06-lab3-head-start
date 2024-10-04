//========================================================================
// Register_RTL-test
//========================================================================

`include "ece2300-test.v"
`include "Register_RTL.v"

module Top();

  //----------------------------------------------------------------------
  // Setup
  //----------------------------------------------------------------------

  logic clk;
  logic reset;

  ece2300_TestUtils t( .* );

  //----------------------------------------------------------------------
  // Instantiate design under test
  //----------------------------------------------------------------------

  logic       dut_rst;
  logic       dut_en;
  logic [7:0] dut_d;
  logic [7:0] dut_q;

  Register_RTL#(8) register
  (
    .clk (clk),
    .rst (reset || dut_rst),
    .en  (dut_en),
    .d   (dut_d),
    .q   (dut_q)
  );

  //----------------------------------------------------------------------
  // check
  //----------------------------------------------------------------------
  // All tasks start at #1 after the rising edge of the clock. So we
  // write the inputs #1 after the rising edge, and check the outputs #1
  // before the next rising edge.

  task check
  (
    input logic       rst,
    input logic       en,
    input logic [7:0] d,
    input logic [7:0] q
  );
    if ( !t.failed ) begin

      dut_rst = rst;
      dut_en  = en;
      dut_d   = d;

      #8;

      if ( t.n != 0 ) begin
        $display( "%3d: %b %b %b > %b", t.cycles,
                  dut_rst, dut_en, dut_d, dut_q );
      end

      `ECE2300_CHECK_EQ( dut_q, q );

      #2;

    end
  endtask

  //----------------------------------------------------------------------
  // test_case_1_basic
  //----------------------------------------------------------------------

  task test_case_1_basic();
    t.test_case_begin( "test_case_1_basic" );

    //    rst en d             q
    check( 0, 1, 8'b0000_0000, 8'b0000_0000 );
    check( 0, 1, 8'b0000_0001, 8'b0000_0000 );
    check( 0, 1, 8'b0000_0000, 8'b0000_0001 );
    check( 0, 1, 8'b0000_0010, 8'b0000_0000 );
    check( 0, 1, 8'b0000_0000, 8'b0000_0010 );

  endtask

  //----------------------------------------------------------------------
  // test_case_2_directed_ones
  //----------------------------------------------------------------------
  // Test registering different values with a single one

  task test_case_2_directed_ones();
    t.test_case_begin( "test_case_2_directed_ones" );

    //''' ACTIVITY '''''''''''''''''''''''''''''''''''''''''''''''''''''''
    // Add checks for directed ones
    //''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    // We provide you the following template, simply fill in the correct
    // values for q for every check

    //    rst en d             q
    check( 0, 1, 8'b0000_0000, ? );
    check( 0, 1, 8'b0000_0001, ? );
    check( 0, 1, 8'b0000_0010, ? );
    check( 0, 1, 8'b0000_0100, ? );
    check( 0, 1, 8'b0000_1000, ? );
    check( 0, 1, 8'b0001_0000, ? );
    check( 0, 1, 8'b0010_0000, ? );
    check( 0, 1, 8'b0100_0000, ? );
    check( 0, 1, 8'b1000_0000, ? );
    check( 0, 1, 8'b0000_0000, ? );

  endtask

  //----------------------------------------------------------------------
  // test_case_3_directed_values
  //----------------------------------------------------------------------
  // Test registering different multi-bit values

  task test_case_3_directed_values();
    t.test_case_begin( "test_case_3_directed_values" );

    //''' ACTIVITY '''''''''''''''''''''''''''''''''''''''''''''''''''''''
    // Add checks for directed values
    //''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    // We provide you the following template, simply fill in the correct
    // values for q for every check

    //    rst en d             q
    check( 0, 1, 8'b0000_0000, ? );
    check( 0, 1, 8'b0011_0011, ? );
    check( 0, 1, 8'b1100_1100, ? );
    check( 0, 1, 8'b0000_1111, ? );
    check( 0, 1, 8'b1111_0000, ? );
    check( 0, 1, 8'b0000_0000, ? );
    check( 0, 1, 8'b1111_1111, ? );
    check( 0, 1, 8'b0000_0000, ? );

  endtask

  //----------------------------------------------------------------------
  // test_case_4_directed_enable
  //----------------------------------------------------------------------
  // Test enable input

  task test_case_4_directed_enable();
    t.test_case_begin( "test_case_4_directed_enable" );

    //''' ACTIVITY '''''''''''''''''''''''''''''''''''''''''''''''''''''''
    // Add checks for directed enable
    //''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    // We provide you the following template, simply fill in the correct
    // values for q for every check

    //    rst en d             q
    check( 0, 1, 8'b0000_0000, ? ); // en=1
    check( 0, 1, 8'b0011_0011, ? );
    check( 0, 1, 8'b1100_1100, ? );

    check( 0, 0, 8'b1111_1111, ? ); // en=0
    check( 0, 0, 8'b1111_0000, ? );
    check( 0, 0, 8'b0000_1111, ? );

    check( 0, 1, 8'b1111_1111, ? ); // en=1
    check( 0, 1, 8'b1111_0000, ? );
    check( 0, 1, 8'b0000_0000, ? );

  endtask

  //----------------------------------------------------------------------
  // test_case_5_directed_reset
  //----------------------------------------------------------------------
  // Test various reset conditions

  task test_case_5_directed_reset();
    t.test_case_begin( "test_case_5_directed_reset" );

    //''' ACTIVITY '''''''''''''''''''''''''''''''''''''''''''''''''''''''
    // Add checks for directed reset
    //''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    // We provide you the following template, simply fill in the correct
    // values for q for every check

    //    rst en d             q
    check( 0, 1, 8'b0000_0000, ? );
    check( 0, 1, 8'b0011_0011, ? );
    check( 0, 1, 8'b1100_1100, ? );

    check( 1, 1, 8'b1111_1111, ? ); // rst=1, en=1
    check( 1, 1, 8'b0000_1111, ? );
    check( 1, 1, 8'b1111_1111, ? );

    check( 0, 1, 8'b1111_0000, ? );
    check( 0, 1, 8'b0011_0011, ? );
    check( 0, 1, 8'b1100_1100, ? );

    check( 1, 0, 8'b1111_1111, ? ); // rst=1, en=0
    check( 1, 0, 8'b0000_1111, ? );
    check( 1, 0, 8'b1111_1111, ? );

    check( 0, 0, 8'b1111_0000, ? );
    check( 0, 0, 8'b0011_0011, ? );
    check( 0, 0, 8'b1100_1100, ? );

  endtask

  //----------------------------------------------------------------------
  // main
  //----------------------------------------------------------------------

  initial begin
    t.test_bench_begin( `__FILE__ );

    if ((t.n <= 0) || (t.n == 1)) test_case_1_basic();
    if ((t.n <= 0) || (t.n == 2)) test_case_2_directed_ones();
    if ((t.n <= 0) || (t.n == 3)) test_case_3_directed_values();
    if ((t.n <= 0) || (t.n == 4)) test_case_4_directed_enable();
    if ((t.n <= 0) || (t.n == 5)) test_case_5_directed_reset();

    t.test_bench_end();
  end

endmodule

