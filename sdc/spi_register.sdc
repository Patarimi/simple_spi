###############################################################################
# Created by write_sdc
# Wed Apr  5 10:04:57 2023
###############################################################################
current_design spi_register
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name reg_clk -period 10.0000 [get_ports {reg_clk}]
set_clock_transition 0.1500 [get_clocks {reg_clk}]
set_clock_uncertainty 0.2500 reg_clk
set_propagated_clock [get_clocks {reg_clk}]
set_input_delay 2.0000 -clock [get_clocks {reg_clk}] -add_delay [get_ports {reg_addr[0]}]
set_input_delay 2.0000 -clock [get_clocks {reg_clk}] -add_delay [get_ports {reg_addr[1]}]
set_input_delay 2.0000 -clock [get_clocks {reg_clk}] -add_delay [get_ports {reg_addr[2]}]
set_input_delay 2.0000 -clock [get_clocks {reg_clk}] -add_delay [get_ports {reg_bus}]
set_input_delay 2.0000 -clock [get_clocks {reg_clk}] -add_delay [get_ports {reg_dir}]
set_output_delay 2.0000 -clock [get_clocks {reg_clk}] -add_delay [get_ports {reg_bus}]
set_output_delay 2.0000 -clock [get_clocks {reg_clk}] -add_delay [get_ports {reg_data[0]}]
set_output_delay 2.0000 -clock [get_clocks {reg_clk}] -add_delay [get_ports {reg_data[1]}]
set_output_delay 2.0000 -clock [get_clocks {reg_clk}] -add_delay [get_ports {reg_data[2]}]
set_output_delay 2.0000 -clock [get_clocks {reg_clk}] -add_delay [get_ports {reg_data[3]}]
set_output_delay 2.0000 -clock [get_clocks {reg_clk}] -add_delay [get_ports {reg_data[4]}]
set_output_delay 2.0000 -clock [get_clocks {reg_clk}] -add_delay [get_ports {reg_data[5]}]
set_output_delay 2.0000 -clock [get_clocks {reg_clk}] -add_delay [get_ports {reg_data[6]}]
set_output_delay 2.0000 -clock [get_clocks {reg_clk}] -add_delay [get_ports {reg_data[7]}]
###############################################################################
# Environment
###############################################################################
set_load -pin_load 0.0334 [get_ports {reg_bus}]
set_load -pin_load 0.0334 [get_ports {reg_data[7]}]
set_load -pin_load 0.0334 [get_ports {reg_data[6]}]
set_load -pin_load 0.0334 [get_ports {reg_data[5]}]
set_load -pin_load 0.0334 [get_ports {reg_data[4]}]
set_load -pin_load 0.0334 [get_ports {reg_data[3]}]
set_load -pin_load 0.0334 [get_ports {reg_data[2]}]
set_load -pin_load 0.0334 [get_ports {reg_data[1]}]
set_load -pin_load 0.0334 [get_ports {reg_data[0]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reg_bus}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reg_clk}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reg_dir}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reg_addr[2]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reg_addr[1]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reg_addr[0]}]
set_timing_derate -early 0.9500
set_timing_derate -late 1.0500
###############################################################################
# Design Rules
###############################################################################
set_max_fanout 10.0000 [current_design]
