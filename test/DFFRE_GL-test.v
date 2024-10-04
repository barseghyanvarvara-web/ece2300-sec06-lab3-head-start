//========================================================================
// DFFRE_GL-test
//========================================================================

`include "ece2300-test.v"
`include "DFFRE_GL.v"

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

  logic dut_clk;
  logic dut_rst;
  logic dut_en;
  logic dut_d;
  logic dut_q;

  DFFRE_GL dffre
  (
    .clk (dut_clk),
    .rst (dut_rst),
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
    input logic _clk,
    input logic rst,
    input logic en,
    input logic d,
    input logic q
  );
    if ( !t.failed ) begin

      dut_clk = _clk;
      dut_rst = rst;
      dut_en  = en;
      dut_d   = d;

      #8;

      if ( t.n != 0 ) begin
        $display( "%3d: %b %b %b %b > %b", t.cycles,
                  dut_clk, dut_rst, dut_en, dut_d, dut_q );
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

    //    clk rst  en d   q
    check( 0, 1,  1,  0,  1'bx );
    check( 1, 1,  1,  0,  0 );
    check( 0, 0,  1,  0,  0 );
    check( 1, 0,  1,  0,  0 );
    check( 0, 0,  1,  0,  0 );

  endtask

  //----------------------------------------------------------------------
  // test_case_2_directed_reset
  //----------------------------------------------------------------------

  task test_case_2_directed_reset();
    t.test_case_begin( "test_case_2_directed_reset" );

    //    clk rs en d  q
    check( 0, 1, 1, 0, 1'bx );

    check( 1, 1, 0, 0, 0 ); // every en,d when clk=1, rst=1
    check( 1, 1, 0, 1, 0 );
    check( 1, 1, 1, 0, 0 );
    check( 1, 1, 1, 1, 0 );

    check( 0, 1, 0, 0, 0 ); // every en,d when clk=0, rst=1
    check( 0, 1, 0, 1, 0 );
    check( 0, 1, 1, 0, 0 );
    check( 0, 1, 1, 1, 0 );

    check( 1, 0, 0, 0, 0 );

  endtask

  //----------------------------------------------------------------------
  // test_case_3_directed_en1
  //----------------------------------------------------------------------

  task test_case_3_directed_en1();
    t.test_case_begin( "test_case_3_directed_en1" );

    //    clk rs en d  q
    check( 0, 1, 0, 0, 1'bx ); // reset sequence
    check( 1, 0, 0, 0, 0 );

    //    clk rs en d  q
    check( 1, 0, 1, 0, 0 ); // d=0, clk=1, ff is storing 0
    check( 1, 0, 1, 1, 0 ); // d=1, clk=1, ff is storing 0
    check( 0, 0, 1, 0, 0 ); // d=0, clk=0, ff is storing 0
    check( 0, 0, 1, 1, 0 ); // d=1, clk=0, ff is storing 0
    check( 1, 0, 1, 0, 1 ); // d=0, clk=1, ff is storing 1
    check( 1, 0, 1, 1, 1 ); // d=1, clk=1, ff is storing 1
    check( 0, 0, 1, 0, 1 ); // d=0, clk=0, ff is storing 1
    check( 0, 0, 1, 1, 1 ); // d=1, clk=0, ff is storing 1
    check( 0, 0, 1, 0, 1 );
    check( 1, 0, 1, 0, 0 ); // return to original state
  endtask

  //----------------------------------------------------------------------
  // test_case_4_directed_en0
  //----------------------------------------------------------------------

  task test_case_4_directed_en0();
    t.test_case_begin( "test_case_4_directed_en0" );

    //    clk rs en d  q
    check( 0, 1, 0, 0, 1'bx ); // reset sequence
    check( 1, 0, 0, 0, 0 );

    //    clk rs en d  q
    check( 1, 0, 0, 0, 0 ); // d=0, clk=1, ff is storing 0
    check( 1, 0, 0, 1, 0 ); // d=1, clk=1, ff is storing 0
    check( 0, 0, 0, 0, 0 ); // d=0, clk=0, ff is storing 0
    check( 0, 0, 0, 1, 0 ); // d=1, clk=0, ff is storing 0
    check( 1, 0, 0, 0, 0 ); // d=0, clk=1, ff is storing 0
    check( 1, 0, 0, 1, 0 ); // d=1, clk=1, ff is storing 0
    check( 0, 0, 0, 0, 0 ); // d=0, clk=0, ff is storing 0
    check( 0, 0, 0, 1, 0 ); // d=1, clk=0, ff is storing 0
    check( 0, 0, 0, 0, 0 );
    check( 1, 0, 0, 0, 0 ); // return to original state

  endtask

  //----------------------------------------------------------------------
  // main
  //----------------------------------------------------------------------

  initial begin
    t.test_bench_begin( `__FILE__ );

    if ((t.n <= 0) || (t.n == 1)) test_case_1_basic();
    if ((t.n <= 0) || (t.n == 2)) test_case_2_directed_reset();
    if ((t.n <= 0) || (t.n == 3)) test_case_3_directed_en1();
    if ((t.n <= 0) || (t.n == 4)) test_case_4_directed_en0();

    t.test_bench_end();
  end

endmodule
