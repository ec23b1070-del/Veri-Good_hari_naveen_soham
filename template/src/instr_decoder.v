module instr_decoder (
    input  [7:0] instr,
    output reg [3:0] opcode,
    output reg [1:0] rd, output reg [1:0] rs1, output reg [1:0] rs2,
    output reg reg_wr_en, output reg ram_wr_en,
    output reg clr_en, output reg inc_en, output reg add64_en, output reg add128_en,
    output reg load_en, output reg mov_en,
    output reg load_acc_h, output reg load_acc_l, output reg mac_en, output reg div_en,
    output reg hlt_en
);
    always @(*) begin
        opcode = instr[7:4];
        rd  = instr[3:2]; 
        rs1 = instr[3:2]; 
        rs2 = instr[1:0]; 

        // Default all to 0
        reg_wr_en=0; ram_wr_en=0; clr_en=0; inc_en=0; add64_en=0; add128_en=0;
        load_en=0; mov_en=0; load_acc_h=0; load_acc_l=0; mac_en=0; div_en=0; hlt_en=0;

        case(opcode)
            4'b0001: begin clr_en = 1; reg_wr_en = 1; end      // CLR
            4'b0010: begin inc_en = 1; reg_wr_en = 1; end      // INC
            4'b0011: begin add64_en = 1; reg_wr_en = 1; end    // ADD_64
            4'b0100: begin add128_en = 1; reg_wr_en = 1; end   // ADD_128
            4'b0101: begin load_en = 1; reg_wr_en = 1; end     // LOAD
            4'b0110: begin ram_wr_en = 1; end                  // STORE
            4'b0111: begin load_acc_h = 1; end                 // L_ACC_H
            4'b1000: begin load_acc_l = 1; end                 // L_ACC_L
            4'b1001: begin mac_en = 1; end                     // MAC
            4'b1010: begin div_en = 1; reg_wr_en = 1; end      // DIV
            4'b1011: begin mov_en = 1; reg_wr_en = 1; end      // MOV
            4'b1100: begin hlt_en = 1; end                     // HLT
            default: ; 
        endcase
    end
endmodule
