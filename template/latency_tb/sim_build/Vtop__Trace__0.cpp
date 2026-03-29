// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vtop__Syms.h"


void Vtop___024root__trace_chg_0_sub_0(Vtop___024root* vlSelf, VerilatedVcd::Buffer* bufp);

void Vtop___024root__trace_chg_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root__trace_chg_0\n"); );
    // Init
    Vtop___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vtop___024root*>(voidSelf);
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (VL_UNLIKELY(!vlSymsp->__Vm_activity)) return;
    // Body
    Vtop___024root__trace_chg_0_sub_0((&vlSymsp->TOP), bufp);
}

void Vtop___024root__trace_chg_0_sub_0(Vtop___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root__trace_chg_0_sub_0\n"); );
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode + 1);
    // Body
    bufp->chgBit(oldp+0,(vlSelf->clk));
    bufp->chgBit(oldp+1,(vlSelf->rst));
    bufp->chgCData(oldp+2,(vlSelf->instr),8);
    bufp->chgWData(oldp+3,(vlSelf->cycle_count),256);
    bufp->chgBit(oldp+11,(vlSelf->top__DOT__clk));
    bufp->chgBit(oldp+12,(vlSelf->top__DOT__rst));
    bufp->chgCData(oldp+13,(vlSelf->top__DOT__instr),8);
    bufp->chgWData(oldp+14,(vlSelf->top__DOT__cycle_count),256);
    bufp->chgCData(oldp+22,(vlSelf->top__DOT__opcode),4);
    bufp->chgCData(oldp+23,(vlSelf->top__DOT__rd),2);
    bufp->chgCData(oldp+24,(vlSelf->top__DOT__rs1),2);
    bufp->chgCData(oldp+25,(vlSelf->top__DOT__rs2),2);
    bufp->chgBit(oldp+26,(vlSelf->top__DOT__reg_wr_en));
    bufp->chgBit(oldp+27,(vlSelf->top__DOT__ram_wr_en));
    bufp->chgBit(oldp+28,(vlSelf->top__DOT__mac_en));
    bufp->chgBit(oldp+29,(vlSelf->top__DOT__load_ram_en));
    bufp->chgBit(oldp+30,(vlSelf->top__DOT__store_ram_en));
    bufp->chgBit(oldp+31,(vlSelf->top__DOT__load_reg_en));
    bufp->chgBit(oldp+32,(vlSelf->top__DOT__store_reg_en));
    bufp->chgCData(oldp+33,(vlSelf->top__DOT__rs1_data),8);
    bufp->chgCData(oldp+34,(vlSelf->top__DOT__rs2_data),8);
    bufp->chgCData(oldp+35,(vlSelf->top__DOT__reg_wr_data),8);
    bufp->chgSData(oldp+36,(vlSelf->top__DOT__mac_out),16);
    bufp->chgSData(oldp+37,(vlSelf->top__DOT__acc_reg),16);
    bufp->chgCData(oldp+38,(vlSelf->top__DOT__ram_rd_data),8);
    bufp->chgCData(oldp+39,(vlSelf->top__DOT__u_decoder__DOT__instr),8);
    bufp->chgCData(oldp+40,(vlSelf->top__DOT__u_decoder__DOT__opcode),4);
    bufp->chgCData(oldp+41,(vlSelf->top__DOT__u_decoder__DOT__rd),2);
    bufp->chgCData(oldp+42,(vlSelf->top__DOT__u_decoder__DOT__rs1),2);
    bufp->chgCData(oldp+43,(vlSelf->top__DOT__u_decoder__DOT__rs2),2);
    bufp->chgBit(oldp+44,(vlSelf->top__DOT__u_decoder__DOT__reg_wr_en));
    bufp->chgBit(oldp+45,(vlSelf->top__DOT__u_decoder__DOT__ram_wr_en));
    bufp->chgBit(oldp+46,(vlSelf->top__DOT__u_decoder__DOT__mac_en));
    bufp->chgBit(oldp+47,(vlSelf->top__DOT__u_decoder__DOT__load_ram_en));
    bufp->chgBit(oldp+48,(vlSelf->top__DOT__u_decoder__DOT__store_ram_en));
    bufp->chgBit(oldp+49,(vlSelf->top__DOT__u_decoder__DOT__load_reg_en));
    bufp->chgBit(oldp+50,(vlSelf->top__DOT__u_decoder__DOT__store_reg_en));
    bufp->chgBit(oldp+51,(vlSelf->top__DOT__u_mac__DOT__clk));
    bufp->chgBit(oldp+52,(vlSelf->top__DOT__u_mac__DOT__rst));
    bufp->chgCData(oldp+53,(vlSelf->top__DOT__u_mac__DOT__a),8);
    bufp->chgCData(oldp+54,(vlSelf->top__DOT__u_mac__DOT__b),8);
    bufp->chgSData(oldp+55,(vlSelf->top__DOT__u_mac__DOT__acc_in),16);
    bufp->chgSData(oldp+56,(vlSelf->top__DOT__u_mac__DOT__acc_out),16);
    bufp->chgBit(oldp+57,(vlSelf->top__DOT__u_ram__DOT__clk));
    bufp->chgBit(oldp+58,(vlSelf->top__DOT__u_ram__DOT__wr_en));
    bufp->chgCData(oldp+59,(vlSelf->top__DOT__u_ram__DOT__addr),8);
    bufp->chgCData(oldp+60,(vlSelf->top__DOT__u_ram__DOT__wr_data),8);
    bufp->chgCData(oldp+61,(vlSelf->top__DOT__u_ram__DOT__rd_data),8);
    bufp->chgIData(oldp+62,(vlSelf->top__DOT__u_ram__DOT__i),32);
    bufp->chgBit(oldp+63,(vlSelf->top__DOT__u_regfile__DOT__clk));
    bufp->chgBit(oldp+64,(vlSelf->top__DOT__u_regfile__DOT__rst));
    bufp->chgBit(oldp+65,(vlSelf->top__DOT__u_regfile__DOT__wr_en));
    bufp->chgCData(oldp+66,(vlSelf->top__DOT__u_regfile__DOT__rd_addr),2);
    bufp->chgCData(oldp+67,(vlSelf->top__DOT__u_regfile__DOT__rs1_addr),2);
    bufp->chgCData(oldp+68,(vlSelf->top__DOT__u_regfile__DOT__rs2_addr),2);
    bufp->chgCData(oldp+69,(vlSelf->top__DOT__u_regfile__DOT__wr_data),8);
    bufp->chgCData(oldp+70,(vlSelf->top__DOT__u_regfile__DOT__rs1_data),8);
    bufp->chgCData(oldp+71,(vlSelf->top__DOT__u_regfile__DOT__rs2_data),8);
    bufp->chgCData(oldp+72,(vlSelf->top__DOT__u_regfile__DOT__regs[0]),8);
    bufp->chgCData(oldp+73,(vlSelf->top__DOT__u_regfile__DOT__regs[1]),8);
    bufp->chgCData(oldp+74,(vlSelf->top__DOT__u_regfile__DOT__regs[2]),8);
    bufp->chgCData(oldp+75,(vlSelf->top__DOT__u_regfile__DOT__regs[3]),8);
    bufp->chgIData(oldp+76,(vlSelf->top__DOT__u_regfile__DOT__i),32);
}

void Vtop___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root__trace_cleanup\n"); );
    // Init
    Vtop___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vtop___024root*>(voidSelf);
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VlUnpacked<CData/*0:0*/, 1> __Vm_traceActivity;
    for (int __Vi0 = 0; __Vi0 < 1; ++__Vi0) {
        __Vm_traceActivity[__Vi0] = 0;
    }
    // Body
    vlSymsp->__Vm_activity = false;
    __Vm_traceActivity[0U] = 0U;
}
