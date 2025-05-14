# Create a new project
#create_project sv_proj ./sv_proj -basys3 xc7a35tcpg236-1 -force

# Add your SystemVerilog top module
add_files top.sv

# Set top module name
set_property top top [current_fileset]

# Run simulation setup
launch_simulation

# Optional: Wait for simulation to initialize
after 1000

# Add specific signals to waveform
#add_wave /top/mac_m
#add_wave /top/mult
#add_wave /top/error
#add_wave /top/dut/*
#add wave sim:/top/mac_m
#add wave sim:/top/mult
#add wave sim:/top/error
#add wave -position -insertpoint sim:/top/dut/*
open_wave_config my_waveform.wcfg
# Run the simulation
run all

