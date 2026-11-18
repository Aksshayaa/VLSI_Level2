
`timescale 1ns/1ps

module tb_alu_4bit;

    reg [3:0] a, b;
    reg [2:0] opcode;
    wire [3:0] result;
    wire carry_out;
    wire zero;

    integer errors;

    alu_4bit dut (
        .a(a),
        .b(b),
        .opcode(opcode),
        .result(result),
        .carry_out(carry_out),
        .zero(zero)
    );

    task check_result;
        input [3:0] expected_result;
        input expected_carry;
        input expected_zero;
        begin
            #10;
            if (result !== expected_result ||
                carry_out !== expected_carry ||
                zero !== expected_zero) begin

                $display("FAIL: opcode=%b A=%d B=%d Result=%d Carry=%b Zero=%b",
                         opcode, a, b, result, carry_out, zero);
                errors = errors + 1;
            end
            else begin
                $display("PASS: opcode=%b A=%d B=%d Result=%d Carry=%b Zero=%b",
                         opcode, a, b, result, carry_out, zero);
            end
        end
    endtask

    initial begin
        errors = 0;
        a = 0;
        b = 0;
        opcode = 0;

        $dumpfile("Reports/alu_waveform.vcd");
        $dumpvars(0, tb_alu_4bit);

        // Addition: 9 + 7 = 16
        a = 4'd9; b = 4'd7; opcode = 3'b000;
        check_result(4'd0, 1'b1, 1'b1);

        // Subtraction: 9 - 3 = 6
        a = 4'd9; b = 4'd3; opcode = 3'b001;
        check_result(4'd6, 1'b0, 1'b0);

        // Subtraction with borrow: 3 - 5 = 14
        a = 4'd3; b = 4'd5; opcode = 3'b001;
        check_result(4'd14, 1'b1, 1'b0);

        // AND: 12 & 10 = 8
        a = 4'd12; b = 4'd10; opcode = 3'b010;
        check_result(4'd8, 1'b0, 1'b0);

        // OR: 8 | 3 = 11
        a = 4'd8; b = 4'd3; opcode = 3'b011;
        check_result(4'd11, 1'b0, 1'b0);

        // XOR: 12 ^ 10 = 6
        a = 4'd12; b = 4'd10; opcode = 3'b100;
        check_result(4'd6, 1'b0, 1'b0);

        // Invalid opcode: default output is zero
        a = 4'd9; b = 4'd7; opcode = 3'b111;
        check_result(4'd0, 1'b0, 1'b1);

        if (errors == 0)
            $display("\nALL ALU TESTS PASSED!");
        else
            $display("\nALU TESTS FAILED: %0d errors", errors);

        $finish;
    end

endmodule
