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

