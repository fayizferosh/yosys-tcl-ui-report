#!/bin/tclsh

# Capturing start time of the script
set start_time [clock clicks -microseconds]

# Variable Creation
# -----------------
# Setting CLI argument to variable where argv is TCL builtin variable containing CLI arguments as list
set dcsv [lindex $argv 0]

# csv file ti matrix processing package
package require csv
package require struct::matrix

# Initialisation of a matrix "m"
struct::matrix m

# Opening design details csv to file handler "f"
set f [open $dcsv]

# Parsing csv data to matrix "m"
csv::read2matrix $f m , auto

# Closing design details csv
close $f

# Command to add columns to matrix
# m add columns $columns

# Storing number of rows and columns of matrix to variables
set ncdcsv [m columns]
set nrdcsv [m rows]

#puts "\nInfo: Below are the list of variable values. For user debug."
#puts "\nDesign csv file total rows = $nrdcsv"
#puts "Design csv file total coulmns = $ncdcsv"

# Convertion of matrix to array "des_arr(column,row)"
m link des_arr

# Auto variable creation and data assignment
set i 0
while {$i < $nrdcsv} {
	puts "\nInfo: Setting $des_arr(0,$i) as '$des_arr(1,$i)'"
	# Checking whether the value of heading is name or path and incase of path making it absolute path
	if { ![string match "*/*" $des_arr(1,$i)] && ![string match "*.*" $des_arr(1,$i)] } {
		# Auto creating variable by replacing spaces in first column with underscore and assigning design name
		set [string map {" " "_"} $des_arr(0,$i)] $des_arr(1,$i)
	} else {
		# Auto creating variable by replacing spaces in first column with underscore and assigning design file/folder absolute path
		set [string map {" " "_"} $des_arr(0,$i)] [file normalize $des_arr(1,$i)]
	}
	set i [expr {$i+1}]
}

#puts "\nInfo: Below are the list of initial variables and their values. User can use these variables for further debug. Use 'puts <variable name>' command to query value of below variables"
#puts "\nDesign_Name = $Design_Name"
#puts "Output_Directory = $Output_Directory"
#puts "Netlist_Directory = $Netlist_Directory"
#puts "Early_Library_Path = $Early_Library_Path"
#puts "Late_Library_Path = $Late_Library_Path"
#puts "Constraints_File = $Constraints_File"

#return

# File/Directory existance check
# ------------------------------
# Checking if output directory exists if not creates one
if { ![file isdirectory $Output_Directory] } {
	puts "\nInfo: Cannot find output directory $Output_Directory. Creating $Output_Directory"
	# mkdir -p to create parent directories if it does not exist
	file mkdir $Output_Directory 
} else {
	puts "\nInfo: Output directory found in path $Output_Directory"
}

# Checking if netlist directory exists if not exits
if { ![file isdirectory $Netlist_Directory] } {
	puts "\nError: Cannot find RTL netlist directory in path $Netlist_Directory. Exiting..."
	exit
} else {
	puts "\nInfo: RTL netlist directory found in path $Netlist_Directory"
}

# Checking if early cell library file exists if not exits
if { ![file exists $Early_Library_Path] } {
	puts "\nError: Cannot find early cell library in path $Early_Library_Path. Exiting..."
	exit
} else {
	puts "\nInfo: Early cell library found in path $Early_Library_Path"
}

# Checking if late cell library file exists if not exits
if { ![file exists $Late_Library_Path] } {
	puts "\nError: Cannot find late cell library in path $Late_Library_Path. Exiting..."
	exit
} else {
	puts "\nInfo: Late cell library found in path $Late_Library_Path"
}

# Checking if constraints file exists if not exits
if { ![file exists $Constraints_File] } {
	puts "\nError: Cannot find constraints file in path $Constraints_File. Exiting..."
	exit
} else {
	puts "\nInfo: Constraints file found in path $Constraints_File"
}

#return

# Constraints csv file data processing for convertion to format[1] and SDC
# ------------------------------------------------------------------------
puts "\nInfo: Dumping SDC constraints for $Design_Name"
::struct::matrix m1
set f1 [open $Constraints_File]
csv::read2matrix $f1 m1 , auto
close $f1
set nrconcsv [m1 rows]
set ncconcsv [m1 columns]
# Finding row number starting for CLOCKS section
set clocks_start [lindex [lindex [m1 search all CLOCKS] 0] 1]
# Finding column number starting for CLOCKS section
set clocks_start_column [lindex [lindex [m1 search all CLOCKS] 0] 0]
# Finding row number starting for INPUTS section
set inputs_start [lindex [lindex [m1 search all INPUTS] 0] 1]
# Finding row number starting for OUTPUTS section
set outputs_start [lindex [lindex [m1 search all OUTPUTS] 0] 1]

#puts "\nInfo: Below are the list of variable values. For user debug."
#puts "\nConstraints csv file total rows = $nrconcsv"
#puts "Constraints csv file total coulmns = $ncconcsv"
#puts "CLOCKS starting row in constraints csv file = $clocks_start"
#puts "CLOCKS starting column in constraints csv file = $clocks_start_column"
#puts "INPUTS starting row in constraints csv file = $inputs_start"
#puts "OUTPUTS starting row in constraints csv file = $outputs_start"

#return

# Convertion of constraints csv file processed data for SDC dumping
# -----------------------------------------------------------------
# CLOCKS section
# Finding column number starting for clock latency in CLOCKS section only
set clocks_erd_start_column [lindex [lindex [m1 search rect $clocks_start_column $clocks_start [expr {$ncconcsv-1}] [expr {$inputs_start-1}] early_rise_delay] 0 ] 0 ]
set clocks_efd_start_column [lindex [lindex [m1 search rect $clocks_start_column $clocks_start [expr {$ncconcsv-1}] [expr {$inputs_start-1}] early_fall_delay] 0 ] 0 ]
set clocks_lrd_start_column [lindex [lindex [m1 search rect $clocks_start_column $clocks_start [expr {$ncconcsv-1}] [expr {$inputs_start-1}] late_rise_delay] 0 ] 0 ]
set clocks_lfd_start_column [lindex [lindex [m1 search rect $clocks_start_column $clocks_start [expr {$ncconcsv-1}] [expr {$inputs_start-1}] late_fall_delay] 0 ] 0 ]

# Finding column number starting for clock transition in CLOCKS section only
set clocks_ers_start_column [lindex [lindex [m1 search rect $clocks_start_column $clocks_start [expr {$ncconcsv-1}] [expr {$inputs_start-1}] early_rise_slew] 0 ] 0 ]
set clocks_efs_start_column [lindex [lindex [m1 search rect $clocks_start_column $clocks_start [expr {$ncconcsv-1}] [expr {$inputs_start-1}] early_fall_slew] 0 ] 0 ]
set clocks_lrs_start_column [lindex [lindex [m1 search rect $clocks_start_column $clocks_start [expr {$ncconcsv-1}] [expr {$inputs_start-1}] late_rise_slew] 0 ] 0 ]
set clocks_lfs_start_column [lindex [lindex [m1 search rect $clocks_start_column $clocks_start [expr {$ncconcsv-1}] [expr {$inputs_start-1}] late_fall_slew] 0 ] 0 ]

# Finding column number starting for frequency and duty cycle in CLOCKS section only
set clocks_freq_start_column [lindex [lindex [m1 search rect $clocks_start_column $clocks_start [expr {$ncconcsv-1}] [expr {$inputs_start-1}] frequency] 0 ] 0 ]
set clocks_dc_start_column [lindex [lindex [m1 search rect $clocks_start_column $clocks_start [expr {$ncconcsv-1}] [expr {$inputs_start-1}] duty_cycle] 0 ] 0 ]

#puts "\nInfo: Below are the list of variable values. For user debug."
#puts "\nClocks early rise delay starting column in the constraints csv file = $clocks_erd_start_column"
#puts "Clocks early fall delay starting column in the constraints csv file = $clocks_efd_start_column"
#puts "Clocks late rise delay starting column in the constraints csv file = $clocks_lrd_start_column"
#puts "Clocks late fall delay starting column in the constraints csv file = $clocks_lfd_start_column"
#puts "Clocks early rise slew starting column in the constraints csv file = $clocks_ers_start_column"
#puts "Clocks early fall slew starting column in the constraints csv file = $clocks_efs_start_column"
#puts "Clocks late rise slew starting column in the constraints csv file = $clocks_lrs_start_column"
#puts "Clocks late fall slew starting column in the constraints csv file = $clocks_lfs_start_column"
#puts "Clocks frequency starting column in the constraints csv file = $clocks_freq_start_column"
#puts "Clocks duty cycle starting column in the constraints csv file = $clocks_dc_start_column"

# Creating .sdc file with design name in output directory and opening it in write mode
set sdc_file [open $Output_Directory/$Design_Name.sdc "w"]

# Setting variables for actual clock row start and end
set i [expr {$clocks_start+1}]
set end_of_clocks [expr {$inputs_start-1}]

#puts "\nInfo: Below are the list of variable values. For user debug."
#puts "\nClocks actual starting row in the constraints csv file = $i"
#puts "Clocks actual ending row in the constraints csv file = $end_of_clocks"

puts "\nInfo-SDC: Working on clock constraints....."

# while loop to write constraint commands to .sdc file
while { $i < $end_of_clocks } {
	#puts "Info: Working on clock '[m1 get cell 0 $i]'. For user debug."

	# create_clock SDC command to create clocks
	puts -nonewline $sdc_file "\ncreate_clock -name [concat [m1 get cell 0 $i]_yui] -period [m1 get cell $clocks_freq_start_column $i] -waveform \{0 [expr {[m1 get cell $clocks_freq_start_column $i]*[m1 get cell $clocks_dc_start_column $i]/100}]\} \[get_ports [m1 get cell 0 $i]\]"

	# set_clock_transition SDC command to set clock transition values
	puts -nonewline $sdc_file "\nset_clock_transition -min -rise [m1 get cell $clocks_ers_start_column $i] \[get_clocks [m1 get cell 0 $i]\]"
	puts -nonewline $sdc_file "\nset_clock_transition -min -fall [m1 get cell $clocks_efs_start_column $i] \[get_clocks [m1 get cell 0 $i]\]"
	puts -nonewline $sdc_file "\nset_clock_transition -max -rise [m1 get cell $clocks_lrs_start_column $i] \[get_clocks [m1 get cell 0 $i]\]"
	puts -nonewline $sdc_file "\nset_clock_transition -max -fall [m1 get cell $clocks_lfs_start_column $i] \[get_clocks [m1 get cell 0 $i]\]"

	# set_clock_latency SDC command to set clock latency values
	puts -nonewline $sdc_file "\nset_clock_latency -source -early -rise [m1 get cell $clocks_erd_start_column $i] \[get_clocks [m1 get cell 0 $i]\]"
	puts -nonewline $sdc_file "\nset_clock_latency -source -early -fall [m1 get cell $clocks_efd_start_column $i] \[get_clocks [m1 get cell 0 $i]\]"
	puts -nonewline $sdc_file "\nset_clock_latency -source -late -rise [m1 get cell $clocks_lrd_start_column $i] \[get_clocks [m1 get cell 0 $i]\]"
	puts -nonewline $sdc_file "\nset_clock_latency -source -late -fall [m1 get cell $clocks_lfd_start_column $i] \[get_clocks [m1 get cell 0 $i]\]"

	set i [expr {$i+1}]
}

#close $sdc_file
#return

# INPUTS section
# Finding column number starting for input clock latency in INPUTS section only
set inputs_erd_start_column [lindex [lindex [m1 search rect $clocks_start_column $inputs_start [expr {$ncconcsv-1}] [expr {$outputs_start-1}] early_rise_delay] 0 ] 0 ]
set inputs_efd_start_column [lindex [lindex [m1 search rect $clocks_start_column $inputs_start [expr {$ncconcsv-1}] [expr {$outputs_start-1}] early_fall_delay] 0 ] 0 ]
set inputs_lrd_start_column [lindex [lindex [m1 search rect $clocks_start_column $inputs_start [expr {$ncconcsv-1}] [expr {$outputs_start-1}] late_rise_delay] 0 ] 0 ]
set inputs_lfd_start_column [lindex [lindex [m1 search rect $clocks_start_column $inputs_start [expr {$ncconcsv-1}] [expr {$outputs_start-1}] late_fall_delay] 0 ] 0 ]

# Finding column number starting for input clock transition in INPUTS section only
set inputs_ers_start_column [lindex [lindex [m1 search rect $clocks_start_column $inputs_start [expr {$ncconcsv-1}] [expr {$outputs_start-1}] early_rise_slew] 0 ] 0 ]
set inputs_efs_start_column [lindex [lindex [m1 search rect $clocks_start_column $inputs_start [expr {$ncconcsv-1}] [expr {$outputs_start-1}] early_fall_slew] 0 ] 0 ]
set inputs_lrs_start_column [lindex [lindex [m1 search rect $clocks_start_column $inputs_start [expr {$ncconcsv-1}] [expr {$outputs_start-1}] late_rise_slew] 0 ] 0 ]
set inputs_lfs_start_column [lindex [lindex [m1 search rect $clocks_start_column $inputs_start [expr {$ncconcsv-1}] [expr {$outputs_start-1}] late_fall_slew] 0 ] 0 ]

# Finding column number starting for input related clock in INPUTS section only
set inputs_rc_start_column [lindex [lindex [m1 search rect $clocks_start_column $inputs_start [expr {$ncconcsv-1}] [expr {$outputs_start-1}] clocks] 0 ] 0 ]

# Setting variables for actual input row start and end
set i [expr {$inputs_start+1}]
set end_of_inputs [expr {$outputs_start-1}]

#puts "\nInfo: Below are the list of variable values. For user debug."
#puts "\nInputs early rise delay starting column in the constraints csv file = $inputs_erd_start_column"
#puts "Inputs early fall delay starting column in the constraints csv file = $inputs_efd_start_column"
#puts "Inputs late rise delay starting column in the constraints csv file = $inputs_lrd_start_column"
#puts "Inputs late fall delay starting column in the constraints csv file = $inputs_lfd_start_column"
#puts "Inputs early rise slew starting column in the constraints csv file = $inputs_ers_start_column"
#puts "Inputs early fall slew starting column in the constraints csv file = $inputs_efs_start_column"
#puts "Inputs late rise slew starting column in the constraints csv file = $inputs_lrs_start_column"
#puts "Inputs late fall slew starting column in the constraints csv file = $inputs_lfs_start_column"
#puts "Inputs related clock starting column in the constraints csv file = $inputs_rc_start_column"
#puts "Inputs actual starting row in the constraints csv file = $i"
#puts "Inputs actual ending row in the constraints csv file = $end_of_inputs"

puts "\nInfo-SDC: Working on input constraints....."
puts "\nInfo-SDC: Categorizing input ports as bits and bussed"

# while loop to write constraint commands to .sdc file
while { $i < $end_of_inputs } {
	# Checking if input is bussed or not
	set netlist [glob -dir $Netlist_Directory *.v]
	set tmp_file [open /tmp/1 w]
	foreach f $netlist {
		set fd [open $f]
		while { [gets $fd line] != -1 } {
			set pattern1 " [m1 get cell 0 $i];"
			if { [regexp -all -- $pattern1 $line] } {
				set pattern2 [lindex [split $line ";"] 0]
				if { [regexp -all {input} [lindex [split $pattern2 "\S+"] 0]] } {
					set s1 "[lindex [split $pattern2 "\S+"] 0] [lindex [split $pattern2 "\S+"] 1] [lindex [split $pattern2 "\S+"] 2]"
					puts -nonewline $tmp_file "\n[regsub -all {\s+} $s1 " "]"
				}
			}
		}
	close $fd
	}
	close $tmp_file
	set tmp_file [open /tmp/1 r]
	set tmp2_file [open /tmp/2 w]
	puts -nonewline $tmp2_file "[join [lsort -unique [split [read $tmp_file] \n]] \n]"
	close $tmp_file
	close $tmp2_file
	set tmp2_file [open /tmp/2 r]
	set count [llength [read $tmp2_file]]
	close $tmp2_file
	if {$count > 2} {
		set inp_ports [concat [m1 get cell 0 $i]*]
		#puts "Info: Working on input bus '$inp_ports'. For user debug."
	} else {
		set inp_ports [m1 get cell 0 $i]
		#puts "Info: Working on input bit '$inp_ports'. For user debug."
	}

	# set_input_transition SDC command to set input transition values
	puts -nonewline $sdc_file "\nset_input_transition -clock \[get_clocks [m1 get cell $inputs_rc_start_column $i]\] -min -rise -source_latency_included [m1 get cell $inputs_ers_start_column $i] \[get_ports $inp_ports\]"
	puts -nonewline $sdc_file "\nset_input_transition -clock \[get_clocks [m1 get cell $inputs_rc_start_column $i]\] -min -fall -source_latency_included [m1 get cell $inputs_efs_start_column $i] \[get_ports $inp_ports\]"
	puts -nonewline $sdc_file "\nset_input_transition -clock \[get_clocks [m1 get cell $inputs_rc_start_column $i]\] -max -rise -source_latency_included [m1 get cell $inputs_lrs_start_column $i] \[get_ports $inp_ports\]"
	puts -nonewline $sdc_file "\nset_input_transition -clock \[get_clocks [m1 get cell $inputs_rc_start_column $i]\] -max -fall -source_latency_included [m1 get cell $inputs_lfs_start_column $i] \[get_ports $inp_ports\]"

	# set_input_delay SDC command to set input latency values
	puts -nonewline $sdc_file "\nset_input_delay -clock \[get_clocks [m1 get cell $inputs_rc_start_column $i]\] -min -rise -source_latency_included [m1 get cell $inputs_erd_start_column $i] \[get_ports $inp_ports\]"
	puts -nonewline $sdc_file "\nset_input_delay -clock \[get_clocks [m1 get cell $inputs_rc_start_column $i]\] -min -fall -source_latency_included [m1 get cell $inputs_efd_start_column $i] \[get_ports $inp_ports\]"
	puts -nonewline $sdc_file "\nset_input_delay -clock \[get_clocks [m1 get cell $inputs_rc_start_column $i]\] -max -rise -source_latency_included [m1 get cell $inputs_lrd_start_column $i] \[get_ports $inp_ports\]"
	puts -nonewline $sdc_file "\nset_input_delay -clock \[get_clocks [m1 get cell $inputs_rc_start_column $i]\] -max -fall -source_latency_included [m1 get cell $inputs_lfd_start_column $i] \[get_ports $inp_ports\]"

	set i [expr {$i+1}]
}

#close $sdc_file
#return

# OUTPUTS section
# Finding column number starting for output clock latency in OUTPUTS section only
set outputs_erd_start_column [lindex [lindex [m1 search rect $clocks_start_column $outputs_start [expr {$ncconcsv-1}] [expr {$nrconcsv-1}] early_rise_delay] 0 ] 0 ]
set outputs_efd_start_column [lindex [lindex [m1 search rect $clocks_start_column $outputs_start [expr {$ncconcsv-1}] [expr {$nrconcsv-1}] early_fall_delay] 0 ] 0 ]
set outputs_lrd_start_column [lindex [lindex [m1 search rect $clocks_start_column $outputs_start [expr {$ncconcsv-1}] [expr {$nrconcsv-1}] late_rise_delay] 0 ] 0 ]
set outputs_lfd_start_column [lindex [lindex [m1 search rect $clocks_start_column $outputs_start [expr {$ncconcsv-1}] [expr {$nrconcsv-1}] late_fall_delay] 0 ] 0 ]

# Finding column number starting for output related clock in OUTPUTS section only
set outputs_rc_start_column [lindex [lindex [m1 search rect $clocks_start_column $outputs_start [expr {$ncconcsv-1}] [expr {$nrconcsv-1}] clocks] 0 ] 0 ]

# Finding column number starting for output load in OUTPUTS section only
set outputs_load_start_column [lindex [lindex [m1 search rect $clocks_start_column $outputs_start [expr {$ncconcsv-1}] [expr {$nrconcsv-1}] load] 0 ] 0 ]

# Setting variables for actual input row start and end
set i [expr {$outputs_start+1}]
set end_of_outputs [expr {$nrconcsv-1}]

puts "\nInfo: Below are the list of variable values. For user debug."
puts "\nOutputs early rise delay starting column in the constraints csv file = $outputs_erd_start_column"
puts "Outputs early fall delay starting column in the constraints csv file = $outputs_efd_start_column"
puts "Outputs late rise delay starting column in the constraints csv file = $outputs_lrd_start_column"
puts "Outputs late fall delay starting column in the constraints csv file = $outputs_lfd_start_column"
puts "Outputs related clock starting column in the constraints csv file = $outputs_rc_start_column"
puts "Outputs load starting column in the constraints csv file = $outputs_load_start_column"
puts "Outputs actual starting row in the constraints csv file = $i"
puts "Outputs actual ending row in the constraints csv file = $end_of_outputs"

puts "\nInfo-SDC: Working on output constraints....."
puts "\nInfo-SDC: Categorizing output ports as bits and bussed"

# while loop to write constraint commands to .sdc file
while { $i < $end_of_outputs } {
	# Checking if input is bussed or not
	set netlist [glob -dir $Netlist_Directory *.v]
	set tmp_file [open /tmp/1 w]
	foreach f $netlist {
		set fd [open $f]
		while { [gets $fd line] != -1 } {
			set pattern1 " [m1 get cell 0 $i];"
			if { [regexp -all -- $pattern1 $line] } {
				set pattern2 [lindex [split $line ";"] 0]
				if { [regexp -all {output} [lindex [split $pattern2 "\S+"] 0]] } {
					set s1 "[lindex [split $pattern2 "\S+"] 0] [lindex [split $pattern2 "\S+"] 1] [lindex [split $pattern2 "\S+"] 2]"
					puts -nonewline $tmp_file "\n[regsub -all {\s+} $s1 " "]"
				}
			}
		}
	close $fd
	}
	close $tmp_file
	set tmp_file [open /tmp/1 r]
	set tmp2_file [open /tmp/2 w]
	puts -nonewline $tmp2_file "[join [lsort -unique [split [read $tmp_file] \n]] \n]"
	close $tmp_file
	close $tmp2_file
	set tmp2_file [open /tmp/2 r]
	set count [llength [read $tmp2_file]]
	close $tmp2_file
	if {$count > 2} {
		set op_ports [concat [m1 get cell 0 $i]*]
		puts "Info: Working on output bus '$op_ports'. For user debug."
	} else {
		set op_ports [m1 get cell 0 $i]
		puts "Info: Working on output bit '$op_ports'. For user debug."
	}

	# set_output_delay SDC command to set output latency values
	puts -nonewline $sdc_file "\nset_output_delay -clock \[get_clocks [m1 get cell $outputs_rc_start_column $i]\] -min -rise -source_latency_included [m1 get cell $outputs_erd_start_column $i] \[get_ports $op_ports\]"
	puts -nonewline $sdc_file "\nset_output_delay -clock \[get_clocks [m1 get cell $outputs_rc_start_column $i]\] -min -fall -source_latency_included [m1 get cell $outputs_efd_start_column $i] \[get_ports $op_ports\]"
	puts -nonewline $sdc_file "\nset_output_delay -clock \[get_clocks [m1 get cell $outputs_rc_start_column $i]\] -max -rise -source_latency_included [m1 get cell $outputs_lrd_start_column $i] \[get_ports $op_ports\]"
	puts -nonewline $sdc_file "\nset_output_delay -clock \[get_clocks [m1 get cell $outputs_rc_start_column $i]\] -max -fall -source_latency_included [m1 get cell $outputs_lfd_start_column $i] \[get_ports $op_ports\]"

	# set_load SDC command to set load values
	puts -nonewline $sdc_file "\nset_load [m1 get cell $outputs_load_start_column $i] \[get_ports $op_ports\]"

	set i [expr {$i+1}]
}

close $sdc_file
puts "\nInfo-SDC: SDC created. Please use constraints in path $Output_Directory/$Design_Name.sdc"

return

# Hierarchy Check
# ---------------
puts "\nInfo: Creating hierarchy check script to be used by Yosys"
set data "read_liberty -lib -ignore_miss_dir -setattr blackbox ${Late_Library_Path}"
puts "Info: Data - '${data}' to write to hierarchy check script. For user debug."
set filename "$Design_Name.hier.ys"
puts "Info: File name of hierarchy script = $filename. For user debug."
set fileId [open $Output_Directory/$filename "w"]
puts -nonewline $fileId $data
set netlist [glob -dir $Netlist_Directory *.v]
puts "Info: All netilsts paths are shown below. For user debug.\n$netlist"
foreach f $netlist {
	puts "Info: Writing netlist path '${f}' to ${filename}. For user debug."
	puts -nonewline $fileId "\nread_verilog $f"
}
puts -nonewline $fileId "\nhierarchy -check"
close $fileId

#return

# Hierarchy check error handling
# Running hierarchy check in yosys by dumping log to log file and catching execution message
set error_flag [catch {exec yosys -s $Output_Directory/$Design_Name.hier.ys >& $Output_Directory/$Design_Name.hierarchy_check.log} msg]
puts "Info: Error flag value = ${error_flag}. For user debug."
if { $error_flag } {
	set filename "$Output_Directory/$Design_Name.hierarchy_check.log"
	puts "Info: Hierarchy check log file name = $filename. For user debug."
	# EDA tool specific hierarchy error search pattern
	set pattern {referenced in module}
	puts "Info: Error pattern = '$pattern'. For user debug."
	set count 0
	set fid [open $filename r]
	while { [gets $fid line] != -1 } {
		incr count [regexp -all -- $pattern $line]
		if { [regexp -all -- $pattern $line] } {
			puts "\nError: Module [lindex $line 2] is not part of design $Design_Name. Please correct RTL in the path '$Netlist_Directory'"
			puts "\nInfo: Hierarchy check FAIL"
		}
	}
	puts "Info: Total number of error pattern detections = $count. For user debug"
	close $fid
	puts "\nInfo: Please find hierarchy check details in '[file normalize $Output_Directory/$Design_Name.hierarchy_check.log]' for more info. Exiting..."
	exit
} else {
	puts "\nInfo: Hierarchy check PASS"
	puts "\nInfo: Please find hierarchy check details in '[file normalize $Output_Directory/$Design_Name.hierarchy_check.log]' for more info"
}

#return


# Capturing end time of the script
set end_time [clock clicks -microseconds]
