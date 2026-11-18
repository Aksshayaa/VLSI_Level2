
`timescale 1ns/1ps

module tb_fsm_datapath;

    reg clk;
    reg reset;
    reg start;
    reg [3:0] data_a;
    reg [3:0] data_b;

    wire [3:0] result;
    wire done;
    wire [2:0] state;

    integer errors;

    localparam IDLE    = 3'b000;
    localparam LOAD    = 3'b001;
    localparam PROCESS = 3'b010;
    localparam DONE    = 3'b011;

    fsm_datapath dut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .data_a(data_a),
        .data_b(data_b),
        .result(result),
        .done(done),
        .state(state)
    );

    // Clock generation
    always #5 clk = ~clk;

    // State checking task
    task check_state;
        input [2:0] expected_state;
        begin
            if (state !== expected_state) begin
                $display("FAIL: Expected state %b, got %b",
                         expected_state, state);
                errors = errors + 1;
            end
            else begin
                $display("PASS: State = %b", state);
            end
        end
    endtask

    initial begin

        clk = 0;
        reset = 1;
        start = 0;
        data_a = 0;
        data_b = 0;
        errors = 0;

        $dumpfile("Waveforms/fsm_waveform.vcd");
        $dumpvars(0, tb_fsm_datapath);

        // TEST 1: Reset
        @(posedge clk);
        #1;
        check_state(IDLE);

        if (result !== 0 || done !== 0) begin
            $display("FAIL: Reset outputs incorrect");
            errors = errors + 1;
        end
        else
            $display("PASS: Reset outputs");

        // Release reset
        @(negedge clk);
        reset = 0;

        // TEST 2: Remain in IDLE
        @(posedge clk);
        #1;
        check_state(IDLE);

        // TEST 3: Start transaction
        @(negedge clk);
        start = 1;
        data_a = 4'd5;
        data_b = 4'd7;

        @(posedge clk);
        #1;
        check_state(LOAD);

        // Deassert start
        @(negedge clk);
        start = 0;

        // TEST 4: LOAD
        @(posedge clk);
        #1;
        check_state(PROCESS);

        // TEST 5: PROCESS
        @(posedge clk);
        #1;
        check_state(DONE);

        if (result !== 4'd12) begin
            $display("FAIL: Expected result 12, got %d", result);
            errors = errors + 1;
        end
        else
            $display("PASS: Datapath result = %d", result);

        // TEST 6: DONE
        @(posedge clk);
        #1;

        if (done !== 1'b1) begin
            $display("FAIL: DONE signal not asserted");
            errors = errors + 1;
        end
        else
            $display("PASS: DONE signal asserted");

        check_state(IDLE);

        // TEST 7: Illegal-state recovery
        @(negedge clk);
        dut.state = 3'b111;

        @(posedge clk);
        #1;

        if (state !== IDLE) begin
            $display("FAIL: Illegal-state recovery failed");
            errors = errors + 1;
        end
        else
            $display("PASS: Illegal-state recovery");

        // TEST 8: Reset during operation
        @(negedge clk);
        start = 1;

        @(posedge clk);
        #1;

        @(negedge clk);
        reset = 1;
        start = 0;

        @(posedge clk);
        #1;

        if (state !== IDLE || result !== 0 || done !== 0) begin
            $display("FAIL: Reset recovery failed");
            errors = errors + 1;
        end
        else
            $display("PASS: Reset recovery");

        // Final result
        if (errors == 0)
            $display("\nALL FSM TESTS PASSED!");
        else
            $display("\nFSM TESTS FAILED: %0d errors", errors);

        $finish;
    end

endmodule
