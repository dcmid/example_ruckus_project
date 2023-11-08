# Set board part for project to RFSoC 4x2
set_property -name "board_part" -value "realdigital.org:rfsoc4x2:part0:1.0" -objects [current_project]

# Uncomment to enable VHDL 2008 in project
# set_property -name "enable_vhdl_2008" -value "1" -objects [current_project]