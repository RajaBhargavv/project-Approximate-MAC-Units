onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group design_accurate -radix unsigned /top/dut/add1
add wave -noupdate -expand -group design_accurate -radix unsigned /top/dut/reg1
add wave -noupdate -expand -group design_accurate -radix unsigned /top/dut/reg2
add wave -noupdate -expand -group design_accurate -radix unsigned /top/dut/mul_out
add wave -noupdate -expand -group design_accurate -radix unsigned /top/dut/mac_out
add wave -noupdate -expand -group test_bench_waves -radix unsigned /top/mult
add wave -noupdate -expand -group test_bench_waves -radix unsigned /top/mac_m
add wave -noupdate -expand -group test_bench_waves -radix unsigned /top/error
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 166
configure wave -valuecolwidth 122
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {1 ns} {120 ns}
