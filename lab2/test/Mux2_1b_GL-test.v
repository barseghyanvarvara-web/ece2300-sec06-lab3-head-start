//========================================================================
// Mux2_1b_GL-test
//========================================================================

`include "ece2300/ece2300-test.v"

// ece2300-lint
`include "lab2/Mux2_1b_GL.v"

module Top();

  //----------------------------------------------------------------------
  // Setup
  //----------------------------------------------------------------------

  CombinationalTestUtils t();

  //----------------------------------------------------------------------
  // Instantiate design under test
  //----------------------------------------------------------------------

  logic in0;
  logic in1;
  logic sel;
  logic out;

  Mux2_1b_GL dut
  (
    .in0 (in0),
    .in1 (in1),
    .sel (sel),
    .out (out)
  );

  //----------------------------------------------------------------------
  // check
  //----------------------------------------------------------------------
  // We set the inputs, wait 8 tau, check the outputs, wait 2 tau. Each
  // check will take a total of 10 tau.

  task check
  (
    input logic in0_,
    input logic in1_,
    input logic sel_,
    input logic out_
  );
    if ( !t.failed ) begin
      t.num_checks += 1;

      in0 = in0_;
      in1 = in1_;
      sel = sel_;

      #8;

      if ( t.n != 0 )
        $display( "%3d: %b %b %b > %b", t.cycles, in0, in1, sel, out );

      `ECE2300_CHECK_EQ( out, out_ );

      #2;

    end
  endtask

  //----------------------------------------------------------------------
  // test_case_1_basic
  //----------------------------------------------------------------------

  task test_case_1_basic();
    t.test_case_begin( "test_case_1_basic" );

    //     in0 in1 sel out
    check( 0,  0,  0,  0 );
    check( 0,  0,  1,  0 );

    t.test_case_end();
  endtask

  //----------------------------------------------------------------------
  // test_case_2_exhaustive
  //----------------------------------------------------------------------

  task test_case_2_exhaustive();
    t.test_case_begin( "test_case_2_exhaustive" );

    //''' LAB ASSIGNMENT '''''''''''''''''''''''''''''''''''''''''''''''''
    // Add checks for exhaustive testing (check all possible inputs)
    //>'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

    //     in0 in1 sel out
    check( 0,  0,  0,  0 );
    check( 0,  0,  1,  0 );
    check( 0,  1,  0,  0 );
    check( 0,  1,  1,  1 );

    check( 1,  0,  0,  1 );
    check( 1,  0,  1,  0 );
    check( 1,  1,  0,  1 );
    check( 1,  1,  1,  1 );

    //<'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

    t.test_case_end();
  endtask

  //----------------------------------------------------------------------
  // test_case_3_xprop
  //----------------------------------------------------------------------

  task test_case_3_xprop();
    t.test_case_begin( "test_case_3_xprop" );

    //''' LAB ASSIGNMENT '''''''''''''''''''''''''''''''''''''''''''''''''
    // Add checks for xprop testing
    //>'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

    //     in0 in1 sel out
    check( 'x, 'x, 'x, 'x );

    //<'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

    t.test_case_end();
  endtask

  //----------------------------------------------------------------------
  // main
  //----------------------------------------------------------------------

  initial begin
    t.test_bench_begin();

    if ((t.n <= 0) || (t.n == 1)) test_case_1_basic();
    if ((t.n <= 0) || (t.n == 2)) test_case_2_exhaustive();
    if ((t.n <= 0) || (t.n == 3)) test_case_3_xprop();

    t.test_bench_end();
  end

endmodule

