module top (
    input clk,
    input rst,
    input [7:0] instr,
    output reg [255:0] cycle_count
);
   
    // Your implementation here





    //your implementation here
    // do not touch this !!!!

    // ===================== CYCLE COUNTER =====================
    always @(posedge clk or posedge rst) begin
        if (rst)
            cycle_count <= 256'b0;
        else
            cycle_count <= cycle_count + 1;
    end
 
endmodule
 
