# u50_qdma design 
Since the U50 Vivado flow is available, folks from hardare may be interested in u50 qdma design with Vivado flow. Here is the simple example of QDMA and HBM to demostrate how to do data DMA from BRAM and host memory. 

# Build the bitstream and MCS

## Environment requirements
* Ubuntu 22.04
* Vivado 23.2
* DPDK v22.11
* Required licenses of used IPs
* U50 acceleration card
* Alveo debug cable 

## Build command
The DPDK test application based on the part of the logic design existing in example design to work. So, the easier way is to instantiate the QDMA IP, input the configuration and open the example design with left click on the IP. This will open a new design in Vivado. Since the U50 need a external output pin to monitor HBM temperature, one output pin need to be manually added in the top of example design, xilinx_qdma_pcie_ep.sv file.
```
output HBM_CATTRIP,
...
assign HBM_CATTRIP = 1'b0;
```

and also the XDC constratins for the new added pin and pcie clock and reset

```
set_property PACKAGE_PIN J18 [get_ports HBM_CATTRIP]
set_property IOSTANDARD LVCMOS18 [get_ports HBM_CATTRIP]
set_property PULLTYPE PULLDOWN [get_ports HBM_CATTRIP]

set_property PACKAGE_PIN AW27 [get_ports sys_rst_n]
set_property PACKAGE_PIN AB9 [get_ports sys_clk_p]
```

All those above manual changes could be done automatically by following command
```
$cd hw
$make 
```

## Program the flash

u50 has one area of flash space which has been written proected. The new flash program need to offset to 0x01002000. The MCS file generated has already applied this requirement. You could use hardare manager GUI to program the flash on U50 as following guideline. 

https://docs.amd.com/r/en-US/ug1371-u50-reconfig-accel/MCS-File-Generation-and-Alveo-Card-Programming

* Select Add Configuration Device and select the mt25qu01g-spi-x1_x2_x4 part
* After programming has completed, disconnect the card in the hardware manager, and disconnect the JTAG programming cable from the Alveo accelerator card.
* Perform a cold reboot on the host machine to complete the card update


# Compile Driver and DPDK

Here is the details of how to compile and run the test with QDMA drivers

https://github.com/Xilinx/dma_ip_drivers/tree/master/QDMA/DPDK

The following is the commands with my Environment to build DPDK

```
$git clone https://github.com/Xilinx/dma_ip_drivers
$git clone http://dpdk.org/git/dpdk-stable
$cd dpdk-stable
$git checkout v22.11
$git clone git://dpdk.org/dpdk-kmods

cp -r ../dma_ip_drivers/QDMA/DPDK/drivers/net/qdma ./drivers/net/ 
cp -r ../dma_ip_drivers/QDMA/DPDK/examples/qdma_testapp ./examples/
```

compile the drivers and test executable based on above guideline

```
$meson build
$cd build
$ninja

$sudo ninja install
$sudo ldconfig

$cd ../dpdk-kmods/linux/igb_uio
$make 
```





Compile test applicatoin
```
$sudo su
#cd examples/qdma_testapp
#make RTE_SDK=`pwd`/../.. RTE_TARGET=build
```



# Check and remove xdma driver if installed before

```
$sudo lsmod |grep xdma
$sudo rm -rf /lib/modules/5.15.0-25-generic/xdma
$sudo depmod -a
```

# Create huge page memory Device and GRUB setting
```

#mkdir /mnt/huge

#cd dpdk-stable/examples/qdma_testapp
#mount -t hugetlbfs nodev /mnt/huge
```

need to update grub configuration on host to enable the hugepage and IOMMU. 
Update the /etc/default/grub file. Please note the IOMMU command is different for Intel and AMD. Here is the example of AMD processor used. 
```
GRUB_CMDLINE_LINUX="default_hugepagesz=1GB hugepagesz=1G hugepages=20 iommu=pt amd_iommu=on numa=off"
```
then update the GRUB and reboot system.
```
#update-grub
```


# Install kernel module drivers
```
#modprobe uio
#insmod ../../dpdk-kmods/linux/igb_uio/igb_uio.ko 
```

Bind PF ports to igb_uio module
```
#../../usertools/dpdk-devbind.py -b igb_uio 01:00.0
```

# Run qdma_testapp 
```
./build/qdma_testapp -c 0xf -n 1
```


## AXI MM data flow testings
```
#port_init <port-id> <num-queues> <num-st-queues> <ring-depth> <pkt-buff-size>
port_init 0 1 0 1024 2048

#dma_to_device <port-id> <num-queues> <input-filename> <dst-addr> <size> <iterations>
dma_from_device 0 1 port0_qcount8_size524288.bin 0 2048 0

#dma_from_device <port-id> <num-queues> <output-filename> <src-addr> <size> <iterations>
dma_to_device 0 1 datafile_8K.bin 0 256 0

```

## AXI Stream data flow testings 
```
#port_init <port-id> <num-queues> <num-st-queues> <ring-depth> <pkt-buff-size>
port_init 0 1 1 1024 2048

#Stream loopback register setting
reg_write 0 2 0x8 0x21

#dma_from_device <port-id> <num-queues> <output-filename> <src-addr> <size> <iterations>
dma_to_device 0 1 datafile_8K.bin 0 256 0

#dma_to_device <port-id> <num-queues> <input-filename> <dst-addr> <size> <iterations>
dma_from_device 0 1 port0_qcount8_size524288.bin 0 256 0

```