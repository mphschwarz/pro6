set_global_assignment -entity "BIDIR" -library "lib_BIDIR" -name IP_TOOL_NAME "altera_gpio_lite"
set_global_assignment -entity "BIDIR" -library "lib_BIDIR" -name IP_TOOL_VERSION "17.1"
set_global_assignment -entity "BIDIR" -library "lib_BIDIR" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_BIDIR" -name SPD_FILE [file join $::quartus(sip_path) "BIDIR.spd"]

set_global_assignment -library "lib_BIDIR" -name MISC_FILE [file join $::quartus(sip_path) "BIDIR_sim/BIDIR.v"]
set_global_assignment -library "lib_BIDIR" -name MISC_FILE [file join $::quartus(sip_path) "BIDIR_sim/altera_gpio_lite/altera_gpio_lite.sv"]
