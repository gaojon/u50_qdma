  
  
create_project -force project_1 u50_qdma -part xcu50-fsvh2104-2-e
set_property BOARD_PART xilinx.com:au50:part0:1.3 [current_project]

create_ip -name qdma -vendor xilinx.com -library ip -version 5.0 -module_name qdma_0
set_property CONFIG.pcie_blk_locn {PCIE4C_X1Y1} [get_ips qdma_0]

open_example_project -force -dir ./ [get_ips  qdma_0]

close_project

open_project qdma_0_ex/qdma_0_ex.xpr



exec sed -i -e "s/input   sys_rst_n/input   sys_rst_n,\\n    output HBM_CATTRIP/" ./qdma_0_ex/imports/xilinx_qdma_pcie_ep.sv
exec sed -i -e "s/wire user_lnk_up;/wire user_lnk_up;\\n    assign HBM_CATTRIP = 1'b0;/" ./qdma_0_ex/imports/xilinx_qdma_pcie_ep.sv

exec cp ../xdc/pins.xdc ./qdma_0_ex/imports/xilinx_pcie_qdma_ref_board.xdc
#exec sed -i -e "\$a\\ set_property PACKAGE_PIN AW27     \[get_ports sys_rst_n\]"      ./qdma_0_ex/imports/xilinx_pcie_qdma_ref_board.xdc
#exec sed -i -e "\$a\\ set_property PACKAGE_PIN J18      \[get_ports HBM_CATTRIP\] " ./qdma_0_ex/imports/xilinx_pcie_qdma_ref_board.xdc
#exec sed -i -e "\$a\\ set_property IOSTANDARD  LVCMOS18 \[get_ports HBM_CATTRIP\] " ./qdma_0_ex/imports/xilinx_pcie_qdma_ref_board.xdc
#exec sed -i -e "\$a\\ set_property PULLDOWN TRUE        \[get_ports HBM_CATTRIP\] " ./qdma_0_ex/imports/xilinx_pcie_qdma_ref_board.xdc





launch_runs impl_1 -to_step write_bitstream -jobs 8
wait_on_run impl_1


write_cfgmem -force -format mcs -interface spix4 -size 128 -loadbit "up 0x01002000 ./qdma_0_ex/qdma_0_ex.runs/impl_1/xilinx_qdma_pcie_ep.bit" -file "u50_qdma.mcs"

start_gui

