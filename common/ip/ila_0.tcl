##################################################################
# CHECK VIVADO VERSION
##################################################################

set scripts_vivado_version 2022.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
  catch {common::send_msg_id "IPS_TCL-100" "ERROR" "This script was generated for Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado."}
  return 1
}


##################################################################
# CREATE IP ila_0
##################################################################

set ila_0 [create_ip -name ila -vendor xilinx.com -library ip -version 6.2 -module_name ila_0]

# User Parameters
set_property -dict [list \
  CONFIG.C_ADV_TRIGGER {true} \
  CONFIG.C_EN_STRG_QUAL {1} \
  CONFIG.C_NUM_OF_PROBES {2} \
  CONFIG.C_PROBE0_WIDTH {1} \
  CONFIG.C_PROBE1_WIDTH {1} \
] [get_ips ila_0]

# Runtime Parameters
set_property -dict { 
  GENERATE_SYNTH_CHECKPOINT {0}
} $ila_0

##################################################################

