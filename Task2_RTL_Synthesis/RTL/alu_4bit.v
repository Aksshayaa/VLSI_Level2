
module alu_4bit (
    input  wire [3:0] a,
    input  wire [3:0] b,
    input  wire [2:0] opcode,
    output reg  [3:0] result,
    output reg        carry_out,
    output wire       zero
);

    always @(*) begin
        result    = 4'b0000;
        carry_out = 1'b0;

        case (opcode)

            3'b000: begin
                {carry_out, result} = {1'b0, a} + {1'b0, b};
            end

            3'b001: begin
                {carry_out, result} = {1'b0, a} - {1'b0, b};
            end

            3'b010: begin
                result = a & b;
            end

            3'b011: begin
                result = a | b;
            end

            3'b100: begin
                result = a ^ b;
            end

            default: begin
                result    = 4'b0000;
                carry_out = 1'b0;
            end

        endcase
    end

    assign zero = (result == 4'b0000);

endmodule
