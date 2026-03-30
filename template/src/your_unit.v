module your_some_unit #(parameter WIDTH = 8) (
    input clk,
    input rst,
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    output reg [2*WIDTH-1:0] out
);

    always @(posedge clk or posedge rst) begin
      // your implementation here
    end

endmodule