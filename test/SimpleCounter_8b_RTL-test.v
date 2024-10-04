//========================================================================
// SimpleCounter_8b_RTL-test
//========================================================================

`include "ece2300-test.v"
`include "SimpleCounter_8b_RTL.v"

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
  logic [7:0] dut_count;

  SimpleCounter_8b_RTL counter
  (
    .clk   (clk),
    .rst   (reset || dut_rst),
    .count (dut_count)
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
    input logic [7:0] count
  );
    if ( !t.failed ) begin

      dut_rst = rst;

      #8;

      if ( t.n != 0 ) begin
        $display( "%3d: %b > %d", t.cycles, dut_rst, dut_count );
      end

      `ECE2300_CHECK_EQ( dut_count, count );

      #2;

    end
  endtask

  //----------------------------------------------------------------------
  // test_case_1_basic
  //----------------------------------------------------------------------

  task test_case_1_basic();
    t.test_case_begin( "test_case_1_basic" );

    //    rst out
    check( 0, 8'd0 );
    check( 0, 8'd1 );
    check( 0, 8'd2 );
    check( 0, 8'd3 );
    check( 0, 8'd4 );

  endtask

  //----------------------------------------------------------------------
  // test_case_2_directed_rollover
  //----------------------------------------------------------------------

  task test_case_2_directed_rollover();
    t.test_case_begin( "test_case_2_directed_rollover" );

    for ( int i = 0; i < 275; i = i+1 )
      check( 0, 8'(i) );

  endtask

  //----------------------------------------------------------------------
  // test_case_3_directed_reset
  //----------------------------------------------------------------------

  task test_case_3_directed_reset();
    t.test_case_begin( "test_case_3_directed_reset" );

    //    rst out
    check( 0, 8'd0 );
    check( 0, 8'd1 );
    check( 0, 8'd2 );
    check( 0, 8'd3 );
    check( 0, 8'd4 );

    check( 1, 8'd5 );
    check( 1, 8'd0 );
    check( 1, 8'd0 );

    check( 0, 8'd0 );
    check( 0, 8'd1 );
    check( 0, 8'd2 );
    check( 0, 8'd3 );
    check( 0, 8'd4 );

  endtask

  //----------------------------------------------------------------------
  // main
  //----------------------------------------------------------------------

  initial begin
    t.test_bench_begin( `__FILE__ );

    if ((t.n <= 0) || (t.n == 1)) test_case_1_basic();
    if ((t.n <= 0) || (t.n == 2)) test_case_2_directed_rollover();
    if ((t.n <= 0) || (t.n == 3)) test_case_3_directed_reset();

    t.test_bench_end();
  end

endmodule

