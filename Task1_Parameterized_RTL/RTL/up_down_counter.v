
module up_down_counter #(
    parameter WIDTH = 8
)(
    input wire clk,
    input wire reset,
    input wire enable,
    input wire direction,  // 1 = UP, 0 = DOWN
    output reg [WIDTH-1:0] count
);

    always @(posedge clk) begin
        if (reset)
            count <= {WIDTH{1'b0}};
        else if (enable) begin
            if (direction)
                count <= count + 1'b1;
            else
                count <= count - 1'b1;
        end
    end

endmodule
