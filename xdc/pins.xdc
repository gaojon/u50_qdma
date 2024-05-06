#################################################################################
#
# Power Constraint to warn User if design will possibly be over cards power limit
#
set_operating_conditions -design_power_budget 63
#
# Bitstream generation
set_property CONFIG_VOLTAGE 1.8 [current_design]
set_property BITSTREAM.CONFIG.CONFIGFALLBACK Enable [current_design]               ;# Golden image is the fall back image if  new bitstream is corrupted.
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property CONFIG_MODE SPIx4 [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 63.8 [current_design]
set_property BITSTREAM.CONFIG.EXTMASTERCCLK_EN disable [current_design]
set_property BITSTREAM.CONFIG.SPI_FALL_EDGE YES [current_design]
set_property BITSTREAM.CONFIG.UNUSEDPIN Pullup [current_design]                    ;# Choices are pullnone, pulldown, and pullup.
set_property BITSTREAM.CONFIG.SPI_32BIT_ADDR Yes [current_design]
#################################################################################


###PCIE

set_property IOSTANDARD LVCMOS18    [get_ports sys_rst_n]
set_property PACKAGE_PIN AW27       [get_ports sys_rst_n]

set_property PACKAGE_PIN AB8  [get_ports sys_clk_n]       ;# Bank 227 - MGTREFCLK0N_227


set_property PACKAGE_PIN AN1 [get_ports {pci_exp_rxn[3]}]        ;# Bank 227 - MGTYRXN0_227
set_property PACKAGE_PIN AK3 [get_ports {pci_exp_rxn[2]}]        ;# Bank 227 - MGTYRXN1_227
set_property PACKAGE_PIN AM3 [get_ports {pci_exp_rxn[1]}]        ;# Bank 227 - MGTYRXN2_227
set_property PACKAGE_PIN AL1 [get_ports {pci_exp_rxn[0]}]        ;# Bank 227 - MGTYRXN3_227
set_property PACKAGE_PIN AN2 [get_ports {pci_exp_rxp[3]}]        ;# Bank 227 - MGTYRXP0_227
set_property PACKAGE_PIN AK4 [get_ports {pci_exp_rxp[2]}]        ;# Bank 227 - MGTYRXP1_227
set_property PACKAGE_PIN AM4 [get_ports {pci_exp_rxp[1]}]        ;# Bank 227 - MGTYRXP2_227
set_property PACKAGE_PIN AL2 [get_ports {pci_exp_rxp[0]}]        ;# Bank 227 - MGTYRXP3_227
set_property PACKAGE_PIN AC6 [get_ports {pci_exp_txn[3]}]        ;# Bank 227 - MGTYTXN0_227
set_property PACKAGE_PIN AB4 [get_ports {pci_exp_txn[2]}]        ;# Bank 227 - MGTYTXN1_227
set_property PACKAGE_PIN AA6 [get_ports {pci_exp_txn[1]}]        ;# Bank 227 - MGTYTXN2_227
set_property PACKAGE_PIN Y4  [get_ports {pci_exp_txn[0]}]        ;# Bank 227 - MGTYTXN3_227
set_property PACKAGE_PIN AC7 [get_ports {pci_exp_txp[3]}]        ;# Bank 227 - MGTYTXP0_227
set_property PACKAGE_PIN AB5 [get_ports {pci_exp_txp[2]}]        ;# Bank 227 - MGTYTXP1_227
set_property PACKAGE_PIN AA7 [get_ports {pci_exp_txp[1]}]        ;# Bank 227 - MGTYTXP2_227
set_property PACKAGE_PIN Y5  [get_ports {pci_exp_txp[0]}]        ;# Bank 227 - MGTYTXP3_227

###HBM #################################################################################

#set_property PACKAGE_PIN BB18     [get_ports "hbm_ref_clk_p[0]"]            ;# Bank  64 VCCO - VCC1V8   - IO_L11P_T1U_N8_GC_64
#set_property IOSTANDARD  LVDS     [get_ports "hbm_ref_clk_p[0]"]            ;# Bank  64 VCCO - VCC1V8   - IO_L11P_T1U_N8_GC_64
#set_property DQS_BIAS TRUE        [get_ports "hbm_ref_clk_p[0]"]            ;# Bank  64 VCCO - VCC1V8   - IO_L11P_T1U_N8_GC_64

# HBM Catastrophic Over temperature Output signal to Satellite Controller
#    HBM_CATTRIP Active high indicator to Satellite controller to indicate the HBM has exceded its maximum allowable temperature.
#                This signal is not a dedicated FPGA output and is a derived signal in RTL. Making the signal Active will shut
#                the FPGA power rails off.
#
set_property PACKAGE_PIN J18      [get_ports "HBM_CATTRIP"]       ;# Bank  68 VCCO - VCC1V8   - IO_L6N_T0U_N11_AD6N_68
set_property IOSTANDARD  LVCMOS18 [get_ports "HBM_CATTRIP"]       ;# Bank  68 VCCO - VCC1V8   - IO_L6N_T0U_N11_AD6N_68
set_property PULLDOWN TRUE        [get_ports "HBM_CATTRIP"]       ;# Bank  68 VCCO - VCC1V8   - IO_L6N_T0U_N11_AD6N_68

#################################################################################

#create_clock -period 10.000 -name hbm_ref_clk -waveform {0.000 5.000} [get_ports {hbm_ref_clk_p[0]}]
create_clock -period 10.000 -name pcie_ref_clk -waveform {0.000 5.000} [get_ports {sys_clk_n}]


#################################################################################
#ILA

set_property MARK_DEBUG true [get_nets qdma_0_i/m_axi_arvalid]
set_property MARK_DEBUG true [get_nets qdma_0_i/m_axi_arready]
set_property MARK_DEBUG true [get_nets qdma_0_i/m_axi_awready]
set_property MARK_DEBUG true [get_nets qdma_0_i/m_axi_awvalid]
set_property MARK_DEBUG true [get_nets qdma_0_i/user_lnk_up]
set_property MARK_DEBUG true [get_nets qdma_0_i/m_axi_rready]
set_property MARK_DEBUG true [get_nets qdma_0_i/m_axi_rvalid]
set_property MARK_DEBUG true [get_nets qdma_0_i/m_axi_wready]
set_property MARK_DEBUG true [get_nets qdma_0_i/s_axis_c2h_tlast]
set_property MARK_DEBUG true [get_nets qdma_0_i/m_axi_wvalid]
set_property MARK_DEBUG true [get_nets qdma_0_i/m_axis_h2c_tlast]
set_property MARK_DEBUG true [get_nets qdma_0_i/m_axis_h2c_tready]
set_property MARK_DEBUG true [get_nets qdma_0_i/m_axis_h2c_tvalid]
set_property MARK_DEBUG true [get_nets qdma_0_i/s_axis_c2h_tready]
set_property MARK_DEBUG true [get_nets qdma_0_i/s_axis_c2h_tvalid]

create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 2 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list qdma_0_i/inst/pcie4c_ip_i/inst/qdma_0_pcie4c_ip_gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_clk_i/CLK_CORECLK]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 1 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list qdma_0_i/m_axi_arready]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 1 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list qdma_0_i/m_axi_arvalid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 1 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list qdma_0_i/m_axi_awready]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 1 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list qdma_0_i/m_axi_awvalid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 1 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list qdma_0_i/m_axi_rready]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 1 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list qdma_0_i/m_axi_rvalid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 1 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list qdma_0_i/m_axi_wready]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 1 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list qdma_0_i/m_axi_wvalid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 1 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list qdma_0_i/m_axis_h2c_tlast]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 1 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list qdma_0_i/m_axis_h2c_tready]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 1 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list qdma_0_i/m_axis_h2c_tvalid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 1 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list qdma_0_i/s_axis_c2h_tlast]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
set_property port_width 1 [get_debug_ports u_ila_0/probe12]
connect_debug_port u_ila_0/probe12 [get_nets [list qdma_0_i/s_axis_c2h_tready]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe13]
set_property port_width 1 [get_debug_ports u_ila_0/probe13]
connect_debug_port u_ila_0/probe13 [get_nets [list qdma_0_i/s_axis_c2h_tvalid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe14]
set_property port_width 1 [get_debug_ports u_ila_0/probe14]
connect_debug_port u_ila_0/probe14 [get_nets [list qdma_0_i/user_lnk_up]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets axi_aclk]

