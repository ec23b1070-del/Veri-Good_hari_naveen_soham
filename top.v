module top (
    input clk,
    input rst,
    input [7:0] instr
);
    // ---------- Decoder outputs ----------
    wire [3:0] opcode;
    wire [1:0] rd, rs1, rs2;
    wire reg_wr_en, ram_wr_en;
    wire mac_en, load_ram_en, store_ram_en, load_reg_en, store_reg_en;
 
    // ---------- Register File wires ----------
    wire [7:0] rs1_data, rs2_data;
    reg  [7:0] reg_wr_data;
 
    // ---------- MAC wires ----------
    wire [15:0] mac_out;
    reg  [15:0] acc_reg;
 
    // ---------- RAM wires ----------
    wire [7:0] ram_rd_data;
 
    // ---------- Cycle Counter ----------
    reg [31:0] cycle_count;
 
    // ===================== INSTANTIATIONS =====================
 
    instr_decoder u_decoder (
        .instr        (instr),
        .opcode       (opcode),
        .rd           (rd),
        .rs1          (rs1),
        .rs2          (rs2),
        .reg_wr_en    (reg_wr_en),
        .ram_wr_en    (ram_wr_en),
        .mac_en       (mac_en),
        .load_ram_en  (load_ram_en),
        .store_ram_en (store_ram_en),
        .load_reg_en  (load_reg_en),
        .store_reg_en (store_reg_en)
    );
 
    reg_file u_regfile (
        .clk      (clk),
        .rst      (rst),
        .wr_en    (reg_wr_en),
        .rd_addr  (rd),
        .rs1_addr (rs1),
        .rs2_addr (rs2),
        .wr_data  (reg_wr_data),
        .rs1_data (rs1_data),
        .rs2_data (rs2_data)
    );
 
    mac_unit #(.WIDTH(8)) u_mac (
        .clk     (clk),
        .rst     (rst),
        .a       (rs1_data),
        .b       (rs2_data),
        .acc_in  (acc_reg),
        .acc_out (mac_out)
    );
 
    ram #(.DEPTH(256), .ADDR_WIDTH(8)) u_ram (
        .clk     (clk),
        .wr_en   (ram_wr_en),
        .addr    ({6'b0, rs2}),
        .wr_data (rs1_data),
        .rd_data (ram_rd_data)
    );
 
    // ===================== CYCLE COUNTER =====================
    always @(posedge clk or posedge rst) begin
        if (rst)
            cycle_count <= 32'b0;
        else
            cycle_count <= cycle_count + 1;
    end
 
    // ===================== ACCUMULATOR UPDATE =====================
    always @(posedge clk or posedge rst) begin
        if (rst)
            acc_reg <= 16'b0;
        else if (mac_en)
            acc_reg <= mac_out;
    end
 
    // ===================== WRITE-BACK MUX =====================
    always @(*) begin
        if (load_ram_en)
            reg_wr_data = ram_rd_data;
        else if (load_reg_en || store_reg_en)
            reg_wr_data = rs1_data;
        else if (mac_en)
            reg_wr_data = mac_out[7:0];
        else
            reg_wr_data = 8'b0;
    end
 
endmodule
 
