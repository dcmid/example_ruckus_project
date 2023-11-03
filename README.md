# Example Vivado Project
This repository provides an example of my typical project structure and build pipeline.

## Prerequisites

The user must have Makefile and Vivado tools installed on their machine and accessible in the terminal with the `make` and `vivado` commands, respectively.

## Makefile
Make provides the majority of the user interface in this project. The available make recipes are summarized below.

| Recipe name | Description | Example call |
| ---         | ---         | ---          |
| help        | Prints out all make recipes and their descriptions. This is run by default when make is called without arguments. | `make` |
| project     | Creates the Vivado project in the _work_ directory, importing sources and generating the block design. | `make project` |
| build       | Builds the existing Vivado project. `make project` must be run first. Output products (.bit, .xdc, .ltx) are saved in the _outputs_ directory. | `make build` |
| all         | Runs the project and build recipes, creating the project from source and then generating output products. | `make all` |
| open_gui    | Opens existing Vivado project in the Vivado GUI. `make project` must be run first. | `make open_gui` |

## Directories

### build_scripts
Containts .tcl scripts for the creation of the Vivado project and its compilation.

### src
Contains all source files used to create the project.

### outputs
Containts important outputs from compilation: bitstream (.bit), hardware definition (.xdc), and probes file (.ltx).

### work
Contains the actual working project. This entire directory is excluded from version control, and its contents are populated from scratch when `make project` is executed.

## Making Design Changes
Any changes made to files in the _src_ directory (and its subdirectories) are tracked by git and will be immediately reflected the next time that `make project` is executed.

Changes made to the block design in the GUI exist only in the _work_ directory and **must** be exported to _src/bd/design1.tcl_ in order to be captured. The _work_ directory is not tracked by git and will be overwritten the next time `make project` is executed.

## Notes
- The included .gigitnore is quite strict, excluding all files not explicitly excepted, so you may need to modify it if you wish to add sources or change the directory structure.
- When building from the terminal, the use of TMUX is suggested so that the build will continue if your terminal session is interrupted.