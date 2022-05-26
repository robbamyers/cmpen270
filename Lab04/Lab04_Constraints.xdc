## Switches
 set_property PACKAGE_PIN V17 [get_ports {SW0}]
	 set_property IOSTANDARD LVCMOS33 [get_ports {SW0}]
 set_property PACKAGE_PIN V16 [get_ports {SW1}]
	 set_property IOSTANDARD LVCMOS33 [get_ports {SW1}]
 set_property PACKAGE_PIN W16 [get_ports {SW2}]
	 set_property IOSTANDARD LVCMOS33 [get_ports {SW2}]
 set_property PACKAGE_PIN W17 [get_ports {SW3}]
	 set_property IOSTANDARD LVCMOS33 [get_ports {SW3}]




##7 segment display
set_property PACKAGE_PIN W7 [get_ports {SEGMENT_A}]
	set_property IOSTANDARD LVCMOS33 [get_ports {SEGMENT_A}]
set_property PACKAGE_PIN W6 [get_ports {SEGMENT_B}]
	set_property IOSTANDARD LVCMOS33 [get_ports {SEGMENT_B}]
set_property PACKAGE_PIN U8 [get_ports {SEGMENT_C}]
	set_property IOSTANDARD LVCMOS33 [get_ports {SEGMENT_C}]
set_property PACKAGE_PIN V8 [get_ports {SEGMENT_D}]
	set_property IOSTANDARD LVCMOS33 [get_ports {SEGMENT_D}]
set_property PACKAGE_PIN U5 [get_ports {SEGMENT_E}]
	set_property IOSTANDARD LVCMOS33 [get_ports {SEGMENT_E}]
set_property PACKAGE_PIN V5 [get_ports {SEGMENT_F}]
	set_property IOSTANDARD LVCMOS33 [get_ports {SEGMENT_F}]
set_property PACKAGE_PIN U7 [get_ports {SEGMENT_G}]
	set_property IOSTANDARD LVCMOS33 [get_ports {SEGMENT_G}]

set_property PACKAGE_PIN V7 [get_ports dp]
	set_property IOSTANDARD LVCMOS33 [get_ports dp]

set_property PACKAGE_PIN U2 [get_ports {ANODE0}]
	set_property IOSTANDARD LVCMOS33 [get_ports {ANODE0}]
set_property PACKAGE_PIN U4 [get_ports {ANODE1}]
	set_property IOSTANDARD LVCMOS33 [get_ports {ANODE1}]
set_property PACKAGE_PIN V4 [get_ports {ANODE2}]
	set_property IOSTANDARD LVCMOS33 [get_ports {ANODE2}]
set_property PACKAGE_PIN W4 [get_ports {ANODE3}]
	set_property IOSTANDARD LVCMOS33 [get_ports {ANODE3}]

## Configuration options, can be used for all designs
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]
