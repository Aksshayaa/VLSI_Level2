
`timescale 1ns/1ps

module tb_up_down_counter;

    parameter WIDTH = 4;

    reg clk;
    reg reset;
    reg enable;
    reg direction;

    wire [WIDTH-1:0] count;

    integer errors;

    up_down_counter #(
        .WIDTH(WIDTH)
    ) DUT (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .direction(direction),
        .count(count)
    );

    always #5 clk = ~clk;

    task check_count;
        input [WIDTH-1:0] expected;
        begin
            @(posedge clk);
            #1;
            if (count !== expected)
             begin
                $display("FAIL: Expected=%0d Actual=%0d",
                         expected, count);
                errors = errors + 1;
            end
            else
             begin
                $display("PASS: Count=%0d", count);
            end
        end
    endtask

    initial 
    begin
    $dumpfile("Results/counter_waveform.vcd");
    $dumpvars(0, tb_up_down_counter);
        clk = 0;
        reset = 0;
        enable = 0;
        direction = 1;
        errors = 0;

        $display("Starting Parameterized Counter Test");

        // Test synchronous reset
        @(negedge clk);
        reset = 1;
        check_count(0);

        // Test UP counting
        @(negedge clk);
        reset = 0;
        enable = 1;
        direction = 1;

        check_count(1);
        check_count(2);
        check_count(3);

        // Test overflow
        check_count(4);
        check_count(5);
        check_count(6);
        check_count(7);
        check_count(8);
        check_count(9);
        check_count(10);
        check_count(11);
        check_count(12);
        check_count(13);
        check_count(14);
        check_count(15);
        check_count(0);

        // Test DOWN counting and underflow
        @(negedge clk);
        direction = 0;
        check_count(15);

        // Test enable = 0 (hold)
        @(negedge clk);
        enable = 0;
        check_count(15);

        // Test reset again
        @(negedge clk);
        reset = 1;
        check_count(0);

        if (errors == 0)
            $display("ALL TESTS PASSED!");
        else
            $display("TESTS FAILED: %0d errors", errors);

        $finish;
    end

endmodule
