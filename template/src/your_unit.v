module your_unit #(parameter WIDTH = 8) (
    input clk,
    input rst,
    input [WIDTH-1:0] a,       // rs1 data
    input [WIDTH-1:0] b,       // rs2 data
    input load_acc_h,          // Acc[15:8] = b
    input load_acc_l,          // Acc[7:0] = b
    input mac_en,              // Acc = Acc - (a * b)
    input div_en,              // Acc = Acc / b
    output [WIDTH-1:0] out_data // Saturated 8-bit output
);
    reg [15:0] acc;
    wire [15:0] prod = a * b;
    wire [15:0] div_res = (b != 0) ? (acc / b) : 16'hFFFF;

    // Lookahead: Immediately route division result to output to avoid 1-cycle delay
    wire [15:0] out_mux = div_en ? div_res : acc;
    
    // Output is strictly 1-byte, saturated per rules
    assign out_data = (out_mux > 255) ? 8'd255 : out_mux[7:0];

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            acc <= 16'b0;
        end else begin
            if (load_acc_h) acc <= {b, acc[7:0]}; 
            else if (load_acc_l) acc <= {acc[15:8], b};
            else if (mac_en) acc <= (acc > prod) ? acc - prod : 16'b0; // Underflow protection
            else if (div_en) acc <= div_res; 
        end
    end
endmodule
