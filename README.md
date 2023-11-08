# Example Ruckus Project
This repository provides an example of a simple Vivado project using the Ruckus build system.

## Prerequisites

The user must have Makefile and Vivado tools installed on their machine and accessible in the terminal with the `make` and `vivado` commands, respectively.

## Quick Start

### Clone the repository
`git clone git@gitlab.xonaspace.com:darren/example_ruckus_project.git`

### Run Ruckus to build the project
```bash
cd example_ruckus_project/targets/RFSoC_4x2
make
```
A firmware image should be generated and output to `example_ruckus_project/targets/RFSoC_4x2/images`.

## Makefile recipes
Ruckus is run using the `Makefile` in a target directory. Some of the most useful recipes are documented below.

| Recipe name | Description | Example call |
| ---         | ---         | ---          |
| *default*   | Creates Vivado project and generates .bit, .ltx, and .xsa (output to `images`) | `make` |
| gui         | Creates Vivado project and opens the GUI | `make gui` |
| interactive | Creates Vivado project and opens in terminal | `make project` |

## Directories

### targets
Contains one directory for each targetted device. These target directories are where Ruckus is called and where outputs are stored.

### common
Contains all sources that are common across platforms

### build
Contains the actual Vivado project and intermediate build files output by Ruckus. This entire directory is excluded from version control. You may need to create it with `mkdir build` when you first clone the repository.

## Making Design Changes
Any changes made to source files in the _common_ and _targets_ directories (and subdirectories) are tracked by git and will be immediately reflected the next time that Ruckus is called.

Changes made to the block design in the GUI exist only in the _build_ directory and **must** be exported to _common/bd/design1.tcl_ in order to be captured. The _build_ directory is not tracked by git and may be overwritten the next time Ruckus is called.

## ruckus.tcl
These scripts are used to import sources using the procedures defined by Ruckus. Some procedures provided by Ruckus for use in this script are documented below.

Note that this script is execured in Vivado with the project opened. As such, any valid Vivado TCL commands can be inserted into the script to achieve custom functionality.

### loadRuckusTcl
This script calls another ruckus.tcl script. It can be used to build a heirarchy of ruckus.tcl scripts, each importing different sources. For example, `targets/<target>/ruckus.tcl` could load all target-specific sources and then call `common/ruckus.tcl`, which would then either import all common sources itself or call more ruckus.tcl scripts in subdirectories.

loadRuckusTcl takes one argument, the path to the directory in which the ruckus.tcl script to be sourced resides.

**Example call:** `loadRuckusTcl $::env(TOP_DIR)/common`

### loadSource
This procedure is used to load HDL sources into the project. 

**Options**
| Option Name | Description | Example Call |
| --- | --- | --- |
| path | Loads one file from a fully-specified path | `loadSource -path "$::DIR_PATH/hdl/inverter.vhd"` |
| dir | Loads all HDL sources in a directory (not recursive) | `loadSource -dir "$::DIR_PATH/hdl"` |
| lib | Specifies library into which to load source | `loadSource -lib utils -path "$::DIR_PATH/hdl/util_pkg.vhd"` |
| fileType | Specifies file type of source. Required for VHDL 2008 files. | `loadSource -fileType {VHDL 2008} -path "$::DIR_PATH/hdl/source_using_vhdl2008.vhd"` |

### loadIpCore
This procedure can be used to load IP sources saves as ".xci" or similar file types into the project. TCL is not supported by this command, but there are workarounds to load IP using TCL scripts (my preferred method.)

**Options**
| Option Name | Description | Example Call |
| --- | --- | --- |
| path | Loads one file from a fully-specified path | `loadIpCore -path "$::DIR_PATH/ip/ila_0.xci"` |
| dir | Loads all ip sources in a directory (not recursive) | `loadIpCore -dir "$::DIR_PATH/ip"` |

### loadBlockDesign
This procedure is used to load Vivado Block Designs into the project. Either TCL scripts or ".bd" files are accepted. 

**Options**
| Option Name | Description | Example Call |
| --- | --- | --- |
| path | Loads one file from a fully-specified path | `loadBlockDesign -path "$::DIR_PATH/bd/design_1.bd"` |
| dir | Loads all block design sources in a directory (not recursive) | `loadBlockDesign -dir "$::DIR_PATH/bd"` |

### loadConstraints
This procedure is used to load constraints files into the project. Both TCL scripts and ".xdc" files are accepted.

**Options**
| Option Name | Description | Example Call |
| --- | --- | --- |
| path | Loads one file from a fully-specified path | `loadConstraints -path "$::DIR_PATH/constraints/timing_constraints.xdc"` |
| dir | Loads all block design sources in a directory (not recursive) | `loadConstraints -dir "$::DIR_PATH/constraints"` |

## Notes
- The included .gigitnore is quite strict, excluding all files not explicitly excepted, so you may need to modify it if you wish to add sources or change the directory structure.
- When building from the terminal, the use of TMUX is suggested so that the build will continue if your terminal session is interrupted.