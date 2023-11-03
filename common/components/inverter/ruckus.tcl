# Load RUCKUS library
source -quiet $::env(RUCKUS_DIR)/vivado_proc.tcl

# Load hdl source
loadSource -dir  "$::DIR_PATH/hdl"