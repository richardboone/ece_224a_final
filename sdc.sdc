###################################################################

# Created by write_sdc on Sun May 15 20:28:34 2016

###################################################################
set sdc_version 2.0

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
set_max_area 0


set_fanout_load 8 [get_ports {res[23]}]
set_fanout_load 8 [get_ports {res[22]}]
set_fanout_load 8 [get_ports {res[21]}]
set_fanout_load 8 [get_ports {res[20]}]
set_fanout_load 8 [get_ports {res[19]}]
set_fanout_load 8 [get_ports {res[18]}]
set_fanout_load 8 [get_ports {res[17]}]
set_fanout_load 8 [get_ports {res[16]}]
set_fanout_load 8 [get_ports {res[15]}]
set_fanout_load 8 [get_ports {res[14]}]
set_fanout_load 8 [get_ports {res[13]}]
set_fanout_load 8 [get_ports {res[12]}]
set_fanout_load 8 [get_ports {res[11]}]
set_fanout_load 8 [get_ports {res[10]}]
set_fanout_load 8 [get_ports {res[9]}]
set_fanout_load 8 [get_ports {res[8]}]
set_fanout_load 8 [get_ports {res[7]}]
set_fanout_load 8 [get_ports {res[6]}]
set_fanout_load 8 [get_ports {res[5]}]
set_fanout_load 8 [get_ports {res[4]}]
set_fanout_load 8 [get_ports {res[3]}]
set_fanout_load 8 [get_ports {res[2]}]
set_fanout_load 8 [get_ports {res[1]}]
set_fanout_load 8 [get_ports {res[0]}]

set_load -pin_load 0.1 [get_ports {res[23]}]
set_load -pin_load 0.1 [get_ports {res[22]}]
set_load -pin_load 0.1 [get_ports {res[21]}]
set_load -pin_load 0.1 [get_ports {res[20]}]
set_load -pin_load 0.1 [get_ports {res[19]}]
set_load -pin_load 0.1 [get_ports {res[18]}]
set_load -pin_load 0.1 [get_ports {res[17]}]
set_load -pin_load 0.1 [get_ports {res[16]}]
set_load -pin_load 0.1 [get_ports {res[15]}]
set_load -pin_load 0.1 [get_ports {res[14]}]
set_load -pin_load 0.1 [get_ports {res[13]}]
set_load -pin_load 0.1 [get_ports {res[12]}]
set_load -pin_load 0.1 [get_ports {res[11]}]
set_load -pin_load 0.1 [get_ports {res[10]}]
set_load -pin_load 0.1 [get_ports {res[9]}]
set_load -pin_load 0.1 [get_ports {res[8]}]
set_load -pin_load 0.1 [get_ports {res[7]}]
set_load -pin_load 0.1 [get_ports {res[6]}]
set_load -pin_load 0.1 [get_ports {res[5]}]
set_load -pin_load 0.1 [get_ports {res[4]}]
set_load -pin_load 0.1 [get_ports {res[3]}]
set_load -pin_load 0.1 [get_ports {res[2]}]
set_load -pin_load 0.1 [get_ports {res[1]}]
set_load -pin_load 0.1 [get_ports {res[0]}]


set_max_fanout 1 [get_ports {op1[11]}]
set_max_fanout 1 [get_ports {op1[10]}]
set_max_fanout 1 [get_ports {op1[9]}]
set_max_fanout 1 [get_ports {op1[8]}]
set_max_fanout 1 [get_ports {op1[7]}]
set_max_fanout 1 [get_ports {op1[6]}]
set_max_fanout 1 [get_ports {op1[5]}]
set_max_fanout 1 [get_ports {op1[4]}]
set_max_fanout 1 [get_ports {op1[3]}]
set_max_fanout 1 [get_ports {op1[2]}]
set_max_fanout 1 [get_ports {op1[1]}]
set_max_fanout 1 [get_ports {op1[0]}]
set_max_fanout 1 [get_ports {op2[11]}]
set_max_fanout 1 [get_ports {op2[10]}]
set_max_fanout 1 [get_ports {op2[9]}]
set_max_fanout 1 [get_ports {op2[8]}]
set_max_fanout 1 [get_ports {op2[7]}]
set_max_fanout 1 [get_ports {op2[6]}]
set_max_fanout 1 [get_ports {op2[5]}]
set_max_fanout 1 [get_ports {op2[4]}]
set_max_fanout 1 [get_ports {op2[3]}]
set_max_fanout 1 [get_ports {op2[2]}]
set_max_fanout 1 [get_ports {op2[1]}]
set_max_fanout 1 [get_ports {op2[0]}]

set_max_fanout 1 [get_ports clk]

create_clock [get_ports clk]  -period 4  -waveform {0 2}

set_clock_latency 0.4  [get_clocks clk]

set_input_delay -clock clk  2  [get_ports clk]

set_input_delay -clock clk  2  [get_ports {op1[11]}]
set_input_delay -clock clk  2  [get_ports {op1[10]}]
set_input_delay -clock clk  2  [get_ports {op1[9]}]
set_input_delay -clock clk  2  [get_ports {op1[8]}]
set_input_delay -clock clk  2  [get_ports {op1[7]}]
set_input_delay -clock clk  2  [get_ports {op1[6]}]
set_input_delay -clock clk  2  [get_ports {op1[5]}]
set_input_delay -clock clk  2  [get_ports {op1[4]}]
set_input_delay -clock clk  2  [get_ports {op1[3]}]
set_input_delay -clock clk  2  [get_ports {op1[2]}]
set_input_delay -clock clk  2  [get_ports {op1[1]}]
set_input_delay -clock clk  2  [get_ports {op1[0]}]
set_input_delay -clock clk  2  [get_ports {op2[11]}]
set_input_delay -clock clk  2  [get_ports {op2[10]}]
set_input_delay -clock clk  2  [get_ports {op2[9]}]
set_input_delay -clock clk  2  [get_ports {op2[8]}]
set_input_delay -clock clk  2  [get_ports {op2[7]}]
set_input_delay -clock clk  2  [get_ports {op2[6]}]
set_input_delay -clock clk  2  [get_ports {op2[5]}]
set_input_delay -clock clk  2  [get_ports {op2[4]}]
set_input_delay -clock clk  2  [get_ports {op2[3]}]
set_input_delay -clock clk  2  [get_ports {op2[2]}]
set_input_delay -clock clk  2  [get_ports {op2[1]}]
set_input_delay -clock clk  2  [get_ports {op2[0]}]

set_output_delay -clock clk  2 [get_ports {res[23]}]
set_output_delay -clock clk  2 [get_ports {res[22]}]
set_output_delay -clock clk  2 [get_ports {res[21]}]
set_output_delay -clock clk  2 [get_ports {res[20]}]
set_output_delay -clock clk  2 [get_ports {res[19]}]
set_output_delay -clock clk  2 [get_ports {res[18]}]
set_output_delay -clock clk  2 [get_ports {res[17]}]
set_output_delay -clock clk  2 [get_ports {res[16]}]
set_output_delay -clock clk  2 [get_ports {res[15]}]
set_output_delay -clock clk  2 [get_ports {res[14]}]
set_output_delay -clock clk  2 [get_ports {res[13]}]
set_output_delay -clock clk  2 [get_ports {res[12]}]
set_output_delay -clock clk  2 [get_ports {res[11]}]
set_output_delay -clock clk  2 [get_ports {res[10]}]
set_output_delay -clock clk  2 [get_ports {res[9]}]
set_output_delay -clock clk  2 [get_ports {res[8]}]
set_output_delay -clock clk  2 [get_ports {res[7]}]
set_output_delay -clock clk  2 [get_ports {res[6]}]
set_output_delay -clock clk  2 [get_ports {res[5]}]
set_output_delay -clock clk  2 [get_ports {res[4]}]
set_output_delay -clock clk  2 [get_ports {res[3]}]
set_output_delay -clock clk  2 [get_ports {res[2]}]
set_output_delay -clock clk  2 [get_ports {res[1]}]
set_output_delay -clock clk  2 [get_ports {res[0]}]
