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

### build_scripts
Containts .tcl scripts for the creation of the Vivado project and its compilation.

### targets
Contains one directory for each targetted device. These target directories are where Ruckus is called and where outputs are stored.

### common
Contains all sources that are common across platforms

### build
Contains the actual Vivado project and intermediate build files output by Ruckus. This entire directory is excluded from version control. You may need to create it with `mkdir build` when you first clone the repository.

## Making Design Changes
Any changes made to source files in the _common_ and _targets_ directories (and subdirectories) are tracked by git and will be immediately reflected the next time that Ruckus is called.

Changes made to the block design in the GUI exist only in the _build_ directory and **must** be exported to _common/bd/design1.tcl_ in order to be captured. The _build_ directory is not tracked by git and may be overwritten the next time Ruckus is called.

## Notes
- The included .gigitnore is quite strict, excluding all files not explicitly excepted, so you may need to modify it if you wish to add sources or change the directory structure.
- When building from the terminal, the use of TMUX is suggested so that the build will continue if your terminal session is interrupted.