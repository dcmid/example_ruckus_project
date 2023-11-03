# override default Ruckus top file, which is project name.
# alternative might be to name wrapper project name, but this
# will require using raw tcl or modifying GenerateBdWrappers
set_property top design_1_wrapper [current_fileset]