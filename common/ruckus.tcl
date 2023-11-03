# Load RUCKUS library
source -quiet $::env(RUCKUS_DIR)/vivado_proc.tcl

# Call ruckus.tcl for all components -- should be made recursive so we don't need so many tcl scripts
loadRuckusTcl "$::DIR_PATH/components/inverter"

# Run tcl to generate IP. Ruckus "loadIP" does not natively support tcl, only xci.
source "$::DIR_PATH/ip/ila_0.tcl"

# Load block design (accepts .bd or .tcl)
loadBlockDesign -path "$::DIR_PATH/bd/design_1.tcl"
# Generate wrapper for block design
# Ruckus automatically calls this in pre_synthesis.tcl, but that isn't executed
# unless synthesis is run (not in interactive or GUI mode)
GenerateBdWrappers