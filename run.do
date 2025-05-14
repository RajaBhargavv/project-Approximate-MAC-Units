vlog top.sv
vsim -novopt -suppress 12110 top
do wave.do
#add wave sim:/top/mac_m
#add wave sim:/top/mult
#add wave sim:/top/error
#add wave -position -insertpoint sim:/top/dut/*
run -all
