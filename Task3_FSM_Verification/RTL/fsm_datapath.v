
module fsm_datapath (
    input wire clk,
    input wire reset,
    input wire start,
    input wire [3:0] data_a,
    input wire [3:0] data_b,

    output reg [3:0] result,
    output reg done,
    output reg [2:0] state
);

    // State encoding
    localparam IDLE    = 3'b000;
    localparam LOAD    = 3'b001;
    localparam PROCESS = 3'b010;
    localparam DONE    = 3'b011;

    reg [3:0] reg_a;
    reg [3:0] reg_b;

    always @(posedge clk) begin

        if (reset) begin
            state  <= IDLE;
            reg_a  <= 4'b0000;
            reg_b  <= 4'b0000;
            result <= 4'b0000;
            done   <= 1'b0;
        end

        else begin

            case (state)

                IDLE: begin
                    done <= 1'b0;

                    if (start)
                        state <= LOAD;
                end

                LOAD: begin
                    reg_a <= data_a;
                    reg_b <= data_b;
                    state <= PROCESS;
                end

                PROCESS: begin
                    result <= reg_a + reg_b;
                    state  <= DONE;
                end

                DONE: begin
                    done  <= 1'b1;
                    state <= IDLE;
                end

                default: begin
                    state  <= IDLE;
                    done   <= 1'b0;
                    reg_a  <= 4'b0000;
                    reg_b  <= 4'b0000;
                    result <= 4'b0000;
                end

            endcase
        end
    end

endmodule
