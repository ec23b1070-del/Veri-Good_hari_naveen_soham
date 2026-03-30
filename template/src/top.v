module top (
    input clk, input rst, input [7:0] instr, output reg [255:0] cycle_count
);
    wire [3:0] opcode;
    wire [1:0] rd, rs1, rs2;
    wire reg_wr, ram_wr, clr_en, inc_en, add64_en, add128_en, load_en, mov_en;
    wire load_acc_h, load_acc_l, mac_en, div_en, hlt_en;

    wire [7:0] rs1_data, rs2_data, ram_rd_data, alu_out;
    reg [7:0] reg_wr_data;

    instr_decoder dec(
        .instr(instr), .opcode(opcode), .rd(rd), .rs1(rs1), .rs2(rs2),
        .reg_wr_en(reg_wr), .ram_wr_en(ram_wr), .clr_en(clr_en), .inc_en(inc_en),
        .add64_en(add64_en), .add128_en(add128_en), .load_en(load_en), .mov_en(mov_en),
        .load_acc_h(load_acc_h), .load_acc_l(load_acc_l), .mac_en(mac_en), .div_en(div_en),
        .hlt_en(hlt_en)
    );

    reg_file rf(.clk(clk), .rst(rst), .wr_en(reg_wr), .rd_addr(rd), .rs1_addr(rs1), 
                .rs2_addr(rs2), .wr_data(reg_wr_data), .rs1_data(rs1_data), .rs2_data(rs2_data));

    your_unit #(.WIDTH(8)) alu(.clk(clk), .rst(rst), .a(rs1_data), .b(rs2_data),
        .load_acc_h(load_acc_h), .load_acc_l(load_acc_l), .mac_en(mac_en), .div_en(div_en),
        .out_data(alu_out));

    ram #(.DEPTH(256), .ADDR_WIDTH(8)) u_ram(.clk(clk), .wr_en(ram_wr), .addr(rs2_data), 
                                             .wr_data(rs1_data), .rd_data(ram_rd_data));

    always @(*) begin
        if (clr_en) reg_wr_data = 8'b0;
        else if (inc_en) reg_wr_data = rs1_data + 1;
        else if (add64_en) reg_wr_data = rs1_data + 64;
        else if (add128_en) reg_wr_data = rs1_data + 128;
        else if (load_en) reg_wr_data = ram_rd_data;
        else if (mov_en) reg_wr_data = rs2_data;
        else if (div_en) reg_wr_data = alu_out; 
        else reg_wr_data = 8'b0;
    end

    // Counter stops automatically upon HLT instruction
    always @(posedge clk or posedge rst) begin
        if (rst) cycle_count <= 0;
        else if (!hlt_en) cycle_count <= cycle_count + 1;
    end
endmodule
