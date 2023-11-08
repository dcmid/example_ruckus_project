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
These scripts are used to import sources using the procedures defined by Ruckus. Some of the most important procedures are documented below.

### loadSource
This procedure is used to load HDL sources into the project. 

**Options**
| name | example | description |
| --- | --- | --- |
| path | `loadSource -path "$::DIR_PATH/hdl/inverter.vhd"` | Loads one file from a fully-specified path |
| dir | `loadSource -dir "$::DIR_PATH/hdl"` | Loads all HDL sources in a directory (not recursive) |
| lib | `loadSource -lib utils -path "$::DIR_PATH/hdl/util_pkg.vhd"` | Specifies library into which to load source |
| fileType | `loadSource -fileType {VHDL 2008} -path "$::DIR_PATH/hdl/source_using_vhdl2008.vhd"` | Specifies file type of source. Required for VHDL 2008 files. |

### loadIpCore
This procedure can be used to load IP sources saves as ".xci" or similar file types into the project. TCL is not supported by this command, but there are workarounds to load IP using TCL scripts (my preferred method.)

**Options**
| name | example | description |
| --- | --- | --- |
| path | `loadIpCore -path "$::DIR_PATH/ip/ila_0.xci"` | Loads one file from a fully-specified path |
| dir | `loadIpCore -dir "$::DIR_PATH/ip"` | Loads all ip sources in a directory (not recursive) |

### loadBlockDesign
This procedure is used to load Vivado Block Designs into the project. Either TCL scripts or ".bd" files are accepted. 

**Options**
| name | example | description |
| --- | --- | --- |
| path | `loadBlockDesign -path "$::DIR_PATH/bd/design_1.bd"` | Loads one file from a fully-specified path |
| dir | `loadBlockDesign -dir "$::DIR_PATH/bd"` | Loads all block design sources in a directory (not recursive) |

### loadConstraints
This procedure is used to load constraints files into the project. Both TCL scripts and ".xdc" files are accepted.

**Options**
| name | example | description |
| --- | --- | --- |
| path | `loadConstraints -path "$::DIR_PATH/constraints/timing_constraints.xdc"` | Loads one file from a fully-specified path |
| dir | `loadConstraints -dir "$::DIR_PATH/constraints"` | Loads all block design sources in a directory (not recursive) |

## Notes
- The included .gigitnore is quite strict, excluding all files not explicitly excepted, so you may need to modify it if you wish to add sources or change the directory structure.
- When building from the terminal, the use of TMUX is suggested so that the build will continue if your terminal session is interrupted.