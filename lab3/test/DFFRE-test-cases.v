//========================================================================
// DFFRE-test-cases
//========================================================================
// This file is meant to be included in a test bench.

//------------------------------------------------------------------------
// check
//------------------------------------------------------------------------
// We set the clock, wait 1 tau, set inputs, wait 7 tau, check the
// outputs, wait 2 tau. Each check will take a total of 10 tau. The
// reason we have to set the clock first, then wait, then set the inputs
// is because in for an RTL implementation we need to avoid a raise
// between writing the clock and the data. The optional final argument
// enables ignoring the output checks when they are undefined.

task check
(
  input logic clk_,
  input logic rst_,
  input logic en_,
  input logic d_,
  input logic q_,
  input logic outputs_undefined = 0
);
  if ( !t.failed ) begin
    t.num_checks += 1;

    clk = clk_;
    #1;
    rst = rst_;
    en  = en_;
    d   = d_;

    #7;

    if ( t.n != 0 )
      $display( "%3d: %b %b %b %b > %b", t.cycles, clk, rst, en, d, q );

    if ( !outputs_undefined )
      `ECE2300_CHECK_EQ( q, q_ );

    #2;

  end
endtask

//------------------------------------------------------------------------
// test_case_1_basic
//------------------------------------------------------------------------

task test_case_1_basic();
  t.test_case_begin( "test_case_1_basic" );

  //    clk rs en d  q
  check( 0, 1, 1, 0, 'x, t.outputs_undefined );
  check( 1, 1, 1, 0, 0 );
  check( 0, 0, 1, 0, 0 );
  check( 1, 0, 1, 0, 0 );
  check( 0, 0, 1, 0, 0 );

  t.test_case_end();
endtask

//------------------------------------------------------------------------
// test_case_2_directed_reset
//------------------------------------------------------------------------

task test_case_2_directed_reset();
  t.test_case_begin( "test_case_2_directed_reset" );

  //''' LAB ASSIGNMENT '''''''''''''''''''''''''''''''''''''''''''''''''''
  // Add checks for reset
  //''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
  // We provide you the following template, simply replace 'x with
  // the correct value for q for every check

  //    clk rs en d  q
  check( 0, 1, 1, 0, 'x, t.outputs_undefined );

  // ---- rising clock edge here ---

  //    clk rs en d  q
  check( 1, 1, 0, 0, 'x ); // every en,d when clk=1, rst=1
  check( 1, 1, 0, 1, 'x );
  check( 1, 1, 1, 0, 'x );
  check( 1, 1, 1, 1, 'x );

  //    clk rs en d  q
  check( 0, 1, 0, 0, 'x ); // every en,d when clk=0, rst=1
  check( 0, 1, 0, 1, 'x );
  check( 0, 1, 1, 0, 'x );
  check( 0, 1, 1, 1, 'x );

  // ---- rising clock edge here ---

  //    clk rs en d  q
  check( 1, 0, 0, 0, 'x );

  t.test_case_end();
endtask

//------------------------------------------------------------------------
// test_case_3_directed_en1
//------------------------------------------------------------------------

task test_case_3_directed_en1();
  t.test_case_begin( "test_case_3_directed_en1" );

  //''' LAB ASSIGNMENT '''''''''''''''''''''''''''''''''''''''''''''''''''
  // Add checks when enable=1
  //''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
  // We provide you the following template, simply replace 'x with
  // the correct value for q for every check

  //    clk rs en d  q
  check( 0, 1, 0, 0, 'x, t.outputs_undefined );

  // ---- rising clock edge here ---

  //    clk rs en d  q
  check( 1, 0, 1, 0, 'x );
  check( 1, 0, 1, 1, 'x );
  check( 0, 0, 1, 0, 'x );
  check( 0, 0, 1, 1, 'x );

  // ---- rising clock edge here ---

  //    clk rs en d  q
  check( 1, 0, 1, 0, 'x );
  check( 1, 0, 1, 1, 'x );
  check( 0, 0, 1, 0, 'x );
  check( 0, 0, 1, 1, 'x );
  check( 0, 0, 1, 0, 'x );

  // ---- rising clock edge here ---

  check( 1, 0, 1, 0, 'x );

  t.test_case_end();
endtask

//------------------------------------------------------------------------
// test_case_4_directed_en0
//------------------------------------------------------------------------

task test_case_4_directed_en0();
  t.test_case_begin( "test_case_4_directed_en0" );

  //''' LAB ASSIGNMENT '''''''''''''''''''''''''''''''''''''''''''''''''''
  // Add checks when enable=0
  //>'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
  // We provide you the following template, simply replace 'x with
  // the correct value for q for every check

  //    clk rs en d  q
  check( 0, 1, 0, 0, 'x, t.outputs_undefined );

  // ---- rising clock edge here ---

  //    clk rs en d  q
  check( 1, 0, 0, 0, 0 'x );
  check( 1, 0, 0, 1, 0 'x );
  check( 0, 0, 0, 0, 0 'x );
  check( 0, 0, 0, 1, 0 'x );

  // ---- rising clock edge here ---

  //    clk rs en d  q
  check( 1, 0, 0, 0, 0 'x );
  check( 1, 0, 0, 1, 0 'x );
  check( 0, 0, 0, 0, 0 'x );
  check( 0, 0, 0, 1, 0 'x );
  check( 0, 0, 0, 0, 0 'x );

  // ---- rising clock edge here ---

  check( 1, 0, 0, 0, 0 'x );

  t.test_case_end();
endtask

//------------------------------------------------------------------------
// test_case_5_xprop
//------------------------------------------------------------------------
// Sequential xprop testing can assume clock is never X.

task test_case_5_xprop();
  t.test_case_begin( "test_case_5_xprop" );

  //    clk rst  en  d   q
  check( 0, 'x, 'x, 'x, 'x, t.outputs_undefined );
  check( 1, 'x, 'x, 'x, 'x );
  check( 0, 'x, 'x, 'x, 'x );
  check( 1, 'x, 'x, 'x, 'x );

  t.test_case_end();
endtask

//------------------------------------------------------------------------
// main
//------------------------------------------------------------------------

initial begin
  t.test_bench_begin();

  if ((t.n <= 0) || (t.n == 1)) test_case_1_basic();
  if ((t.n <= 0) || (t.n == 2)) test_case_2_directed_reset();
  if ((t.n <= 0) || (t.n == 3)) test_case_3_directed_en1();
  if ((t.n <= 0) || (t.n == 4)) test_case_4_directed_en0();
  if ((t.n <= 0) || (t.n == 5)) test_case_5_xprop();

  t.test_bench_end();
end

