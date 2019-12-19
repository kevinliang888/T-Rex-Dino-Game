vlib work

# Compile all Verilog modules in mux.v to working dir;
# could also have multiple Verilog files.
# The timescale argument defines default time unit
# (used when no unit is specified), while the second number
# defines precision (all times are rounded to this value)
vlog -timescale 1ns/1ns datapath2.v

# Load simulation using datapath2 as the top level simulation module.
vsim datapath2

# Log all signals and add some signals to waveform window.
log {/*}
# add wave {/*} would add all items in top level simulation module.
add wave {/*}

force {clock} 0 0ns, 1 5ns -r 10ns
force {resetn} 0 0ns, 1 10ns
force {colour} 3#001
force {en_delay} 0 0ns, 1 10ns, 0 20ns
force {draw} 0 0ns, 1 20ns, 0 40ns
force {en_xy} 0 0ns, 1 40ns
force {erase_colour} 0 0ns, 1 30ns, 0 40ns
run 100ns
