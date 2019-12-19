vlib work

# Compile all Verilog modules in poly_function to working dir;
# could also have multiple Verilog files.
# The timescale argument defines default time unit
# (used when no unit is specified), while the second number
# defines precision (all times are rounded to this value)
vlog -timescale 1ns/1ns project.v

# Load simulation using part2 as the top level simulation module.
vsim DinoGame
# Log all signals and add some signals to waveform window.
log {/*}
# add wave {/*} would add all items in top level simulation module.
add wave {/*}


force {clk} 0 0, 1 5 -r 10
force {resetn} 0 0, 1 10

force {jump} 0 0, 1 20 -r 40
force {x} 100
force {y} 450 0, 10 20, 300 40

force {data_in[7:0]} 00000001 0, 00000011 20,  00000010 40

run 350ns