<!---
![Yosys_TCL_UI](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/970d192f-4eee-40b2-b285-51ce1c663677)
![Yosys_TCL_UI (3)](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/4c91c984-fd74-47c7-a599-72e7f7f30594)
![Yosys_TCL_UI (2)](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/d2b2ddff-35e9-450a-b28a-8f21ae766c4d)
-->
![Yosys_TCL_UI (4)](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/ee23feab-44d4-4d7f-b5d9-fdf120a4a684)
# Yosys TCL UI

![Static Badge](https://img.shields.io/badge/OS-linux-orange)
![Static Badge](https://img.shields.io/badge/EDA%20Tools-Yosys%2C_OpenTimer-navy)
![Static Badge](https://img.shields.io/badge/languages-verilog%2C_bash%2C_TCL-crimson)
![GitHub last commit](https://img.shields.io/github/last-commit/fayizferosh/yosys-tcl-ui-report)
![GitHub language count](https://img.shields.io/github/languages/count/fayizferosh/yosys-tcl-ui-report)
![GitHub top language](https://img.shields.io/github/languages/top/fayizferosh/yosys-tcl-ui-report)
![GitHub repo size](https://img.shields.io/github/repo-size/fayizferosh/yosys-tcl-ui-report)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/fayizferosh/yosys-tcl-ui-report)
![GitHub repo file count (file type)](https://img.shields.io/github/directory-file-count/fayizferosh/yosys-tcl-ui-report)
<!---
Comments
-->

> 5 Day TCL training workshop by VSD using Yosys and Opentimer open-source eda tools and TCL to generate a report from a design wherein the input is design file paths in .csv format to the tcl program. The final objective by day 5 is to give design details namely paths of design data to the "TCL BOX" which is the UI being designed which runs the design in Yosys and Opentimer open-source eda tools and returns a report of the design.

![Screenshot (264)](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/dcf3a9f9-2281-4d6f-b318-a52ddea1fb7d)
![Screenshot (265)](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/6194ce14-1cf5-41c2-9de3-6938f205f912)

## Requirements

* Linux OS
* Yosys Synthesis Suite
* OpenTimer STA Tool
* TCL Matrix Package

## Usage

Clone the repo and in the directory in bash terminal run `./yosysui openMSP430_design_details.csv` and then design '*openMSP430*' Yosys synthesis and OpenTimer STA will be run and at the end you will recieve '*PRELAYOUT TIMING RESULTS*' as illustrated in above images. (Before running make sure to edit the procs paths in script and OpenTimer tool path as well to your local paths)

***Note: The screenshots in following sections are purely based on the 'yosysui.tcl' script that I have uploaded and is not a direct output of the code snippet of corresponding section. The code snippets contains only the crucial portions of the 'yosysui.tcl' script required to execute the tasks mentioned in the respective sections.***

## Day 1 - Introduction to TCL and VSDSYNTH Toolbox Usage (23/08/2023)

Day 1 task is to create command (in my case ***yosysui***) and pass .csv file from UNIX shell to TCL script taking into consideration mainly 3 general scenarios from user point of view.

![Screenshot 2023-08-24 183526](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/a1c31fb3-a8e5-4a7e-987d-3d7e6ff4ad65)

**Review of input files provided in work directory**

![Screenshot from 2023-08-23 22-48-19](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/7dd31089-d1a4-44a2-9d31-f828af25e37c)

**Review of input file - openMSP430_design_details.csv**

![Screenshot from 2023-08-23 22-29-25](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/de69f8ea-92cc-40e6-b570-e7a364c72c04)

### Implementation

Creation of *yosysui* command script and *yosysui.tcl* files.

![Screenshot from 2023-08-24 19-28-08](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/53d902f7-9ec4-4a8f-a2cd-683f74a7ca2f)

*yosysui.tcl*

![Screenshot from 2023-08-24 19-36-52](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/c0e5a04d-2d6b-40ea-bcd1-9bd76be60116)

Basic structure of bash code used for implementation of general scenarios.

```bash
# Tool Initialisation
if [ $# -eq 0 ]; then
	echo "Info: Please provide the csv file"
	exit 1
elif [ $# -gt 1 ] && [ $1 != *.csv ]; then
	echo "Info: Please provide only one csv file"
	exit 1
else
	if [[ $1 != *.csv ]] && [ $1 != "-help" ]; then
		echo "Info: Please provide a .csv format file"
		exit 1
	fi
fi

if [ ! -e $1 ] || [ $1 == "-help" ]; then
	if [ $1 != "-help" ]; then
		echo "Error: Cannot find csv file $1. Exiting..."
		exit 1
	else
		echo "USAGE:  ./yosysui <csv file>"
		echo
		echo "        where <csv file> consists of 2 columns, below keyword being in 1st column and is Case Sensitive. Please request Fayiz for sample csv file."
		echo
		echo "        <Design Name> is the name of top level module."
		echo
		echo "        <Output Directory> is the name of output directory where you want to dump synthesis script, synthesized netlist and timing reports."
		echo
		echo "        <Netlist Directory> is the name of directory where all RTL netlist are present."
		echo
		echo "        <Early Library Path> is the file path of the early cell library to be used for STA."
		echo
		echo "        <Late Library Path> is file path of the late cell library to be used for STA."
		echo
		echo "        <Constraints file> is csv file path of constraints to be used for STA."
		echo
	fi
else
	echo "Info: csv file $1 accepted"
	tclsh yosysui.tcl $1
fi
```

In my command ***yosysui*** I have implemented a total of *5 general scenarios* from user point of view in the bash script.

#### 1. No input file provided

![Screenshot from 2023-08-24 19-39-50](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/cb679d28-e0de-448a-ad2a-5d31031d2f8b)

#### 2. File provided exists but is not of .csv format

![Screenshot from 2023-08-24 19-41-41](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/45653ab6-96be-49f1-8af2-afcce1ee0392)

#### 3. More than one file or parameters provided

![Screenshot from 2023-08-24 19-53-06](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/8ad5345c-1fa8-4432-b618-b5a0bd5f3934)

#### 4. Provide a .csv file that does not exist

![Screenshot from 2023-08-24 19-54-26](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/96ee26cd-43ed-4056-a1ac-c42a5207542a)

#### 5. Type "-help" to find out usage

![Screenshot from 2023-08-24 19-55-32](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/86488924-9fe5-4702-a41d-3916ac7044de)

## Day 2 - Variable Creation and Processing Constraints from CSV (24/08/2023)

Day 2 task is to basically write the TCL code in *yosysui.tcl* for variable creation, file/directory existance check and the processing of the constraints csv file to convert it into format[1] (which is the constraints format taken as input by Yosys tool) and as well as into SDC (Synopsys Design Constraints) format (which is the industry standard format).

![Screenshot (266)](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/43c630e2-0f02-4a38-b5c4-5d61d098ce62)

**Review of input file - openMSP430_design_constraints.csv**

![Screenshot from 2023-08-23 22-51-48](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/c72f9e71-4650-4ead-bb66-d5a1d9cdd53d)

### Implementation

I have successfully completed Day 2 tasks namely variable creation, file/directory existance check and the processing of the constraints csv file.

**yosysui.tcl snapshot**

![Screenshot from 2023-08-25 23-12-20](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/2320f228-0b66-420d-85ff-80ce3d77bbc8)

#### Variable Creation

I have auto created the variables (*have used special condition to identify design name*) from the csv file by converting it into a matrix and then to an array (*also added command to capture start time of script so that it can be used to calculate runtime at the end*). The basic code of the same and screenshot of terminal with several "puts" printing out the variables are shown below.

*Code*

```tcl
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

# Storing number of rows and columns of matrix to variables
set ncdcsv [m columns]
set nrdcsv [m rows]

# Convertion of matrix to array "des_arr(column,row)"
m link des_arr

# Auto variable creation and data assignment
set i 0
while {$i < $nrdcsv} {
	puts "\nInfo: Setting $des_arr(0,$i) as '$des_arr(1,$i)'"
	if { ![string match "*/*" $des_arr(1,$i)] && ![string match "*.*" $des_arr(1,$i)] } {
		set [string map {" " "_"} $des_arr(0,$i)] $des_arr(1,$i)
	} else {
		set [string map {" " "_"} $des_arr(0,$i)] [file normalize $des_arr(1,$i)]
	}
	set i [expr {$i+1}]
}
```

*Screenshot*

![Screenshot from 2023-08-25 23-24-20](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/88934e7b-89f1-4557-a186-cc23816ce5d9)

#### File / Directory Existance Check

I have written the code to check the existance of all files and directories wherein the program exits incase it is not found since, these files and directories existance are crucial for the program to move further except for output directory which is created if not existing. The basic code of the same and screenshots of terminal demonstrating the functionality namely one showing creation od new output directory and another in which output directory exist but constraints file does not exist are shown below.

*Code*

```tcl
# File/Directory existance check
# ------------------------------
# Checking if output directory exists if not creates one
if { ![file isdirectory $Output_Directory] } {
	puts "\nInfo: Cannot find output directory $Output_Directory. Creating $Output_Directory"
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
```

*Screenshots*

![Screenshot from 2023-08-25 23-47-49](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/39f36a9a-8b57-46af-961b-ea17af372296)
![Screenshot from 2023-08-25 23-56-51](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/b0911e12-4739-4e52-9f43-bd8368c4e7e8)

#### Processing of the constraints openMSP430_design_constraints.csv file

The file was successfully processesed and converted into matrix and the rows and columns count were extracted as well as starting rows of clocks, inputs and outputs were also extracted. The basic code of the same and screenshot of terminal with several "puts" printing out the variables are shown below.

*Code*

```tcl
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
```

*Screenshot*

<!---
![Screenshot from 2023-08-26 00-09-40](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/7114a964-971f-46ee-b6a8-831ea83c0145)
-->
![Screenshot from 2023-08-26 23-12-07](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/ea0b3f15-f7bd-488e-bf47-b70331cbec1e)

## Day 3 - Processing Clock and Input Constraints from CSV and dumping SDC (26/08/2023)

Day 3 task is to basically processing constraints csv file for clocks and inputs and dupming SDC commands to .sdc file with actual processed data. It involves several matrix search algorithms and also an algorithm to identify inputs which are buses and bits differently.

**Review of input file - openMSP430_design_constraints.csv**

![Screenshot from 2023-08-26 23-29-38](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/58f22f6a-b861-4b32-917c-fed1268c19b0)

### Implementation

I have successfully completed Day 3 tasks namely processing constraints csv file for clocks and inputs and dupming SDC commands to .sdc file with actual processed data.

#### Processing of the constraints .csv file for CLOCKS and dumping SDC commands to .sdc

I have successfully processed the csv file for CLOCKS data and dumped clock based SDC commands (*with unique clock names adding "_yui" to SDC create_clock command*) to .sdc file. The basic code of the same and screenshots of terminal with several "puts" printing out the variables and user debug information as well as output .sdc are shown below.

*Code*

```tcl
# Convertion of constraints csv file to SDC
# -----------------------------------------
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

# Creating .sdc file with design name in output directory and opening it in write mode
set sdc_file [open $Output_Directory/$Design_Name.sdc "w"]

# Setting variables for actual clock row start and end
set i [expr {$clocks_start+1}]
set end_of_clocks [expr {$inputs_start-1}]

puts "\nInfo-SDC: Working on clock constraints....."

# while loop to write constraint commands to .sdc file
while { $i < $end_of_clocks } {
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
```

*Screenshots*

![Screenshot from 2023-08-26 23-55-47](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/2cdfc6a3-41ce-4386-8d57-a4c4d891e39c)
![Screenshot from 2023-08-26 23-56-04](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/806e80b6-4a21-4a6f-b35c-0954092cef2d)

*openMSP430.sdc*

![Screenshot from 2023-08-26 23-55-01](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/289108e2-fb13-4194-a4a7-529ce3c05aa4)

#### Processing of the constraints .csv file for INPUTS and dumping SDC commands to .sdc

I have successfully processed the csv file for INPUTS data as well as differentiated bit and bus inputs and dumped inputs based SDC commands to .sdc file. The basic code of the same and screenshots of terminal with several "puts" printing out the variables and user debug information as well as output .sdc are shown below.

*Code*

```tcl
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
	} else {
		set inp_ports [m1 get cell 0 $i]
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
```

*Screenshots*

![Screenshot from 2023-08-27 00-15-11](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/19e7ccfe-3fc0-4b91-b9da-f09910570204)
![Screenshot from 2023-08-27 00-16-01](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/c93a1551-c951-4714-9ac2-c974b9425b99)

*openMSP430.sdc*

![Screenshot from 2023-08-27 00-14-56](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/e73aee2d-a63b-4937-89ff-d7d7d21b1abe)

/tmp/1 and /tmp/2 file screenshots for bit port

*/tmp/1*

![Screenshot from 2023-08-29 15-47-50](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/626396d2-fb93-47e7-931f-e75546397972)

*/tmp/2*

![Screenshot from 2023-08-29 15-47-30](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/8c27a27e-7693-4017-9f35-52e35ee59dde)


/tmp/1 and /tmp/2 file screenshots for bussed port

*/tmp/1*

![Screenshot from 2023-08-29 15-42-44](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/e16d45ea-24ee-47c2-baf9-e90a35134bc6)

*/tmp/2*

![Screenshot from 2023-08-29 15-42-57](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/b7b0e600-7dc5-492f-87d4-27b8fa16f7e0)

## Day 4 - Complete Scripting and Yosys Synthesis Introduction (26/08/2023)

Day 4 task included the outputs section processing and dumping of SDC file, sample yosys synthesis using example memory and explanation, yosys hierarchy check and it's error handling.

**Review of input file - openMSP430_design_constraints.csv**

![Screenshot from 2023-08-29 15-51-51](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/a0251a70-a667-4c03-99cb-430d0cec1ef8)

### Implementation

I have successfully completed Day 4 tasks namely processing constraints csv file for outputs and dupming SDC commands to .sdc file with actual processed data, learned sample memory synthesis and it's memory write and read process, dumped hierarchy check yosys script and wrote code handling errors in herarchy check.

#### Processing of the constraints .csv file for OUTPUTS and dumping SDC commands to .sdc

I have successfully processed the csv file for OUTPUTS data as well as differentiated bit and bus outputs and dumped outputs based SDC commands to .sdc file. The basic code of the same and screenshots of terminal with several "puts" printing out the variables and user debug information as well as output .sdc are shown below.

*Code*

```tcl
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
	} else {
		set op_ports [m1 get cell 0 $i]
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
```

*Screenshots*

![Screenshot from 2023-08-29 15-55-10](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/8fd704f2-c0c7-480f-99d0-d88cd64d445c)
![Screenshot from 2023-08-29 15-56-02](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/e2679927-2b37-4028-854a-27672a078dc5)
![Screenshot from 2023-08-29 15-56-18](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/f999bb4f-09a5-4983-8519-2614206ee2f4)

*openMSP430.sdc*

![Screenshot from 2023-08-29 15-57-13](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/c6f188ac-4fba-46cc-bebd-166a78226cb3)

/tmp/1 and /tmp/2 files similar to input ports

#### Memory module yosys synthesis and explanation

The verilog code *memory.v* for a single bit address and single bit data memory unit is given below.

*Code*

```verilog
module memory (CLK, ADDR, DIN, DOUT);

parameter wordSize = 1;
parameter addressSize = 1;

input ADDR, CLK;
input [wordSize-1:0] DIN;
output reg [wordSize-1:0] DOUT;
reg [wordSize:0] mem [0:(1<<addressSize)-1];

always @(posedge CLK) begin
	mem[ADDR] <= DIN;
	DOUT <= mem[ADDR];
	end

endmodule
```

The basic yosys script *memory.ys* to run this and obtain a gate-level netlist and 2D representation of the memory module in gate components is provided below.

*Script*

```tcl
# Reding the library
read_liberty -lib -ignore_miss_dir -setattr blackbox /home/kunalg/Desktop/work/openmsp430/openmsp430/osu018_stdcells.lib
# Reading the verilog
read_verilog memory.v
synth top memory
splitnets -ports -format ___
dfflibmap -liberty /home/kunalg/Desktop/work/openmsp430/openmsp430/osu018_stdcells.lib
opt
abc -liberty /home/kunalg/Desktop/work/openmsp430/openmsp430/osu018_stdcells.lib
flatten
clean -purge
opt
clean
# Writing the netlist
write_verilog memory_synth.v
# Representation of netlist with it's components
show
```

The output view of netlist from the code is shown below.

![Screenshot (267)](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/82137c89-b8f5-4b98-996b-e7e6fe6516a1)

*Memory write process explained in following images using truth table*

Basic illustration of write process

![Screenshot (268)](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/44d4b869-a861-41c6-90a0-4d2e9a0ff38c)

Before first rising edge of the clock

![Screenshot (272)](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/7c1cbdc0-ccbe-4010-ae5d-2af6317d7459)

After first rising edge of the clock - write process done

![Screenshot (273)](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/f6d57546-e60e-4cfe-bf20-601d5962d000)

*Memory read process explained in following images using truth table*

Basic illustration of read process

![Screenshot (269)](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/2dff99ae-b568-4b7a-93ac-78cfa112a9ed)

After first rising edge and before second rising edge of the clock

![Screenshot (274)](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/4940be06-9546-4652-908d-44cd96050d6a)

After second rising edge of the clock - read process done

![Screenshot (275)](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/ab0a4c9c-fd2b-48ee-b9ff-d068c2bdfbf1)

#### Hierarchy check script dumping

I have successfully written the code for dumping hierarchy check script. The basic code of the same and screenshots of terminal with several "puts" printing out the variables and user debug information as well as output .hier.ys are shown below.

*Code*

```tcl
# Hierarchy Check
# ---------------
puts "\nInfo: Creating hierarchy check script to be used by Yosys"
set data "read_liberty -lib -ignore_miss_dir -setattr blackbox ${Late_Library_Path}"
set filename "$Design_Name.hier.ys"
set fileId [open $Output_Directory/$filename "w"]
puts -nonewline $fileId $data
set netlist [glob -dir $Netlist_Directory *.v]
foreach f $netlist {
	puts -nonewline $fileId "\nread_verilog $f"
}
puts -nonewline $fileId "\nhierarchy -check"
close $fileId
```

*Screenshots*

![Screenshot from 2023-08-29 16-02-41](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/a035dbe3-9271-4d9d-a7d4-56a6f962fdaf)
![Screenshot from 2023-08-29 16-03-08](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/531faa6f-e51d-4ff5-a289-9eb39240db04)
![Screenshot from 2023-08-29 16-03-26](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/6bcd71ba-1063-4d38-b822-78af29e8aa94)

*openMSP430.hier.ys*

![Screenshot from 2023-08-29 16-04-58](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/98b04685-79dc-44b2-9ba4-c400db8548d6)

#### Hierarchy Check Run & Error Handling

I have successfully written the code for hierarchy check error handling in case any error pops up during hierarchy check run in yosys and *exits if hierarchy check fails*. The basic code of the same and screenshots of terminal with several "puts" printing out the variables and user debug information are shown below.

*Code*

```tcl
# Hierarchy check error handling
# Running hierarchy check in yosys by dumping log to log file and catching execution message
set error_flag [catch {exec yosys -s $Output_Directory/$Design_Name.hier.ys >& $Output_Directory/$Design_Name.hierarchy_check.log} msg]
if { $error_flag } {
	set filename "$Output_Directory/$Design_Name.hierarchy_check.log"
	# EDA tool specific hierarchy error search pattern
	set pattern {referenced in module}
	set count 0
	set fid [open $filename r]
	while { [gets $fid line] != -1 } {
		incr count [regexp -all -- $pattern $line]
		if { [regexp -all -- $pattern $line] } {
			puts "\nError: Module [lindex $line 2] is not part of design $Design_Name. Please correct RTL in the path '$Netlist_Directory'"
			puts "\nInfo: Hierarchy check FAIL"
		}
	}
	close $fid
	puts "\nInfo: Please find hierarchy check details in '[file normalize $Output_Directory/$Design_Name.hierarchy_check.log]' for more info. Exiting..."
	exit
} else {
	puts "\nInfo: Hierarchy check PASS"
	puts "\nInfo: Please find hierarchy check details in '[file normalize $Output_Directory/$Design_Name.hierarchy_check.log]' for more info"
}
```

*Screenshots*

![Screenshot from 2023-08-29 16-10-14](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/bbf9a540-8836-4d2d-84b5-b29586d7f340)

*openMSP430.hierarchy_check.log*

![Screenshot from 2023-08-29 16-10-54](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/c8588d8f-4003-4496-be2f-11043647f3b2)

![Screenshot from 2023-08-29 16-13-12](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/028cb5d6-0324-4e08-844f-062cd8dc7505)

*openMSP430.hierarchy_check.log*

![Screenshot from 2023-08-29 16-14-22](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/7d0f3e55-95a1-421d-a099-cb13b330c4f2)

## Day 5 - Advanced Scripting Techniques and Quality of Results (QoR) Generation (27/08/2023)

Day 5 task is to run main synthesis in yosys, learn about procs and use it in an application level creating commands, write necesserary files required for OpenTimer tool such as .conf - .spef - .timing, write OpenTimer script, run OpenTimer STA, collect required data to form QoR from .results file generated from OpenTimer STA run & finally print the collected data in a tool standard QoR output format.

### Implementation

I have sucessfully coded all the required elements to achieve Day 5 tasks and all the details of sub-task achieved are shown below.

#### Main yosys synthesis script dumping

I have successfully written the code for main yosys synthesis script .ys file and dumped the script. The basic code of the same and screenshots of terminal with several "puts" printing out the variables and user debug information are shown below.

*Code*

```tcl
# Main Synthesis Script
# ---------------------
puts "\nInfo: Creating main synthesis script to be used by Yosys"
set data "read_liberty -lib -ignore_miss_dir -setattr blackbox ${Late_Library_Path}"
set filename "$Design_Name.ys"
set fileId [open $Output_Directory/$filename "w"]
puts -nonewline $fileId $data
set netlist [glob -dir $Netlist_Directory *.v]
foreach f $netlist {
	puts -nonewline $fileId "\nread_verilog $f"
}
puts -nonewline $fileId "\nhierarchy -top $Design_Name"
puts -nonewline $fileId "\nsynth -top $Design_Name"
puts -nonewline $fileId "\nsplitnets -ports -format ___\ndfflibmap -liberty ${Late_Library_Path} \nopt"
puts -nonewline $fileId "\nabc -liberty ${Late_Library_Path}"
puts -nonewline $fileId "\nflatten"
puts -nonewline $fileId "\nclean -purge\niopadmap -outpad BUFX2 A:Y -bits\nopt\nclean"
puts -nonewline $fileId "\nwrite_verilog $Output_Directory/$Design_Name.synth.v"
close $fileId
puts "\nInfo: Synthesis script created and can be accessed from path $Output_Directory/$Design_Name.ys"
```

*Screenshots*

![Screenshot from 2023-08-29 16-21-48](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/8ff84ce4-26af-4a01-93b4-d435bbfd767c)
![Screenshot from 2023-08-29 16-22-21](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/83af9314-c349-45cb-bde2-be5d6035d3a1)
![Screenshot from 2023-08-29 16-22-40](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/82881cc7-b27f-4a39-a04b-f5dfdd847649)

*openMSP430.ys*

![Screenshot from 2023-08-29 16-23-16](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/6273dd9c-4ef4-4e9a-beb7-f7e6a0606943)

#### Running main synthesis script & error handling

I have successfully written the code for running main yosys synthesis script and exiting if errors are found. The basic code of the same and screenshots of terminal are shown below.

*Code*

```tcl
puts "\nInfo: Running synthesis..........."
# Main synthesis error handling
# Running main synthesis in yosys by dumping log to log file and catching execution message
if { [catch {exec yosys -s $Output_Directory/$Design_Name.ys >& $Output_Directory/$Design_Name.synthesis.log} msg] } {
	puts "\nError: Synthesis failed due to errors. Please refer to log $Output_Directory/$Design_Name.synthesis.log for errors. Exiting...."
	exit
} else {
	puts "\nInfo: Synthesis finished successfully"
}
puts "\nInfo: Please refer to log $Output_Directory/$Design_Name.synthesis.log"
```

*Screenshots*

![Screenshot from 2023-08-29 16-31-45](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/fd204cbb-9a76-4a4b-a0c9-e2bf0924396b)
![Screenshot from 2023-08-29 16-35-18](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/c5df53d3-c644-43c5-9f07-f84215615487)

*openMSP430.synthesis.log*

![Screenshot from 2023-08-29 16-36-16](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/8ca12680-9570-4cbb-a69d-662f3d31705d)

#### Editing .synth.v to be usable by OpenTimer

I have successfully written the code to edit the main synthesis output netlist .synth.v to make it usable for OpenTimer and other STA and PnR needs by replacing lines with "*" as a word and by removing "\" from any and all lines that have it. The basic code of the same and screenshots of terminal with several "puts" printing out the variables and user debug information are shown below.

*Code*

```tcl
# Editing .synth.v to be usable by Opentimer
# ------------------------------------------
set fileId [open /tmp/1 "w"]
puts -nonewline $fileId [exec grep -v -w "*" $Output_Directory/$Design_Name.synth.v]
close $fileId
set output [open $Output_Directory/$Design_Name.final.synth.v "w"]
set filename "/tmp/1"
set fid [open $filename r]
while { [gets $fid line] != -1 } {
	puts -nonewline $output [string map {"\\" ""} $line]
	puts -nonewline $output "\n"
}
close $fid
close $output
puts "\nInfo: Please find the synthesized netlist for $Design_Name at below path. You can use this netlist for STA or PNR"
puts "\nPath: $Output_Directory/$Design_Name.final.synth.v"
```

*Screenshots*

![Screenshot from 2023-08-29 16-40-59](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/df6c6458-b390-4a5a-957a-a516e9917042)

*openMSP430.synth.v*

![Screenshot from 2023-08-29 16-45-19](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/6995d59c-89fb-460f-9aa1-0ba99ffa55e3)

*/tmp/1*

![Screenshot from 2023-08-29 16-45-38](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/13c74231-6309-4e7c-9291-d7debabdd5f8)

*openMSP430.final.synth.v*

![Screenshot from 2023-08-29 16-46-26](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/8f1f5555-58b9-4053-af9f-aa1b075c6446)

#### World of Procs (TCL Procedure)

Procs can be used to create user defined commands as shown below. I have successfully written the code for all the procs. The basic codes of the all the procs and screenshots of terminal with several "puts" printing out the variables and user debug information for 'set_multi_cpu_usage' and 'read_sdc' proc are shown below.

##### reopenStdout.proc

This proc redirects the 'stdout' screen log to argument file.

*Code*

```tcl
#!/bin/tclsh

# proc to redirect screen log to file
proc reopenStdout {file} {
    close stdout
    open $file w       
}
```

##### set_multi_cpu_usage.proc

This proc outputs multiple threads of cpu usage command required for OpenTimer tool.

*Code*

```tcl
#!/bin/tclsh

proc set_multi_cpu_usage {args} {
        array set options {-localCpu <num_of_threads> -help "" }
        while {[llength $args]} {
                switch -glob -- [lindex $args 0] {
                	-localCpu {
				set args [lassign $args - options(-localCpu)]
				puts "set_num_threads $options(-localCpu)"
			}
                	-help {
				set args [lassign $args - options(-help) ]
				puts "Usage: set_multi_cpu_usage -localCpu <num_of_threads> -help"
				puts "\t-localCpu - To limit CPU threads used"
				puts "\t-help - To print usage"
                      	}
                }
        }
}
```

*Screenshots*

![Screenshot from 2023-08-29 16-53-58](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/21a2a36c-c1d8-43d8-88b3-a01954c890d8)

##### read_lib.proc

This proc outputs commands to read early and late libraries required for OpenTimer tool.

*Code*

```tcl
#!/bin/tclsh

proc read_lib args {
	# Setting command parameter options and its values
	array set options {-late <late_lib_path> -early <early_lib_path> -help ""}
	while {[llength $args]} {
		switch -glob -- [lindex $args 0] {
		-late {
			set args [lassign $args - options(-late) ]
			puts "set_late_celllib_fpath $options(-late)"
		      }
		-early {
			set args [lassign $args - options(-early) ]
			puts "set_early_celllib_fpath $options(-early)"
		       }
		-help {
			set args [lassign $args - options(-help) ]
			puts "Usage: read_lib -late <late_lib_path> -early <early_lib_path>"
			puts "-late <provide late library path>"
			puts "-early <provide early library path>"
			puts "-help - Provides user deatails on how to use the command"
		      }	
		default break
		}
	}
}
```

##### read_verilog.proc

This proc outputs commands to read synthesised netlist required for OpenTimer tool.

*Code*

```tcl
#!/bin/tclsh

# Proc to convert read_verilog to OpenTimer format
proc read_verilog {arg1} {
	puts "set_verilog_fpath $arg1"
}
```

##### read_sdc.proc

This proc outputs commands to read constraints .timing file required for OpenTimer tool. This procs converts SDC file contents to .timing file format for use by OpenTimer tools and the convertion code is explained stage by stage with sufficient screenshots.

###### Converting 'create_clock' constraints

Initially the proc takes SDC file as input argument or parameter and processes 'create_clock' constaint part of SDC.

*Code*

```tcl
#!/bin/tclsh

proc read_sdc {arg1} {

# 'file dirname <>' to get directory path only from full path
set sdc_dirname [file dirname $arg1]
# 'file tail <>' to get last element
set sdc_filename [lindex [split [file tail $arg1] .] 0 ]
set sdc [open $arg1 r]
set tmp_file [open /tmp/1 w]

# Removing "[" & "]" from SDC for further processing the data with 'lindex'
# 'read <>' to read entire file
puts -nonewline $tmp_file [string map {"\[" "" "\]" " "} [read $sdc]]     
close $tmp_file

# Opening tmp file to write constraints converted from generated SDC
set timing_file [open /tmp/3 w]

# Converting create_clock constraints
# -----------------------------------
set tmp_file [open /tmp/1 r]
set lines [split [read $tmp_file] "\n"]
# 'lsearch -all -inline' to search list for pattern and retain elementas with pattern only
set find_clocks [lsearch -all -inline $lines "create_clock*"]
foreach elem $find_clocks {
	set clock_port_name [lindex $elem [expr {[lsearch $elem "get_ports"]+1}]]
	set clock_period [lindex $elem [expr {[lsearch $elem "-period"]+1}]]
	set duty_cycle [expr {100 - [expr {[lindex [lindex $elem [expr {[lsearch $elem "-waveform"]+1}]] 1]*100/$clock_period}]}]
	puts $timing_file "\nclock $clock_port_name $clock_period $duty_cycle"
}
close $tmp_file
```

*Screenshots*

*/tmp/1*

![Screenshot from 2023-08-29 17-11-08](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/328687aa-0faa-41dd-8d9c-df4a8c504711)

*/tmp/3*

![Screenshot from 2023-08-29 17-11-40](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/4e63234f-c254-4c1c-8574-0d5570ce55b0)

###### Converting 'set_clock_latency' constraints

Processes 'set_clock_latency' constaint part of SDC.

*Code*

```tcl
# Converting set_clock_latency constraints
# ----------------------------------------
set find_keyword [lsearch -all -inline $lines "set_clock_latency*"]
set tmp2_file [open /tmp/2 w]
set new_port_name ""
foreach elem $find_keyword {
        set port_name [lindex $elem [expr {[lsearch $elem "get_clocks"]+1}]]
	if {![string match $new_port_name $port_name]} {
        	set new_port_name $port_name
        	set delays_list [lsearch -all -inline $find_keyword [join [list "*" " " $port_name " " "*"] ""]]
        	set delay_value ""
        	foreach new_elem $delays_list {
        		set port_index [lsearch $new_elem "get_clocks"]
        		lappend delay_value [lindex $new_elem [expr {$port_index-1}]]
        	}
		puts -nonewline $tmp2_file "\nat $port_name $delay_value"
	}
}

close $tmp2_file
set tmp2_file [open /tmp/2 r]
puts -nonewline $timing_file [read $tmp2_file]
close $tmp2_file
```

*Screenshots*

*/tmp/2*

![Screenshot from 2023-08-29 17-23-07](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/768611ac-19fc-4fa5-8f12-31c26085682b)

*/tmp/3*

![Screenshot from 2023-08-29 17-23-57](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/ee297383-a993-4623-9ada-f31b01be1239)

###### Converting 'set_clock_transition' constraints

Processes 'set_clock_transition' constaint part of SDC.

*Code*

```tcl
# Converting set_clock_transition constraints
# -------------------------------------------
set find_keyword [lsearch -all -inline $lines "set_clock_transition*"]
set tmp2_file [open /tmp/2 w]
set new_port_name ""
foreach elem $find_keyword {
        set port_name [lindex $elem [expr {[lsearch $elem "get_clocks"]+1}]]
        if {![string match $new_port_name $port_name]} {
		set new_port_name $port_name
		set delays_list [lsearch -all -inline $find_keyword [join [list "*" " " $port_name " " "*"] ""]]
        	set delay_value ""
        	foreach new_elem $delays_list {
        		set port_index [lsearch $new_elem "get_clocks"]
        		lappend delay_value [lindex $new_elem [expr {$port_index-1}]]
        	}
        	puts -nonewline $tmp2_file "\nslew $port_name $delay_value"
	}
}

close $tmp2_file
set tmp2_file [open /tmp/2 r]
puts -nonewline $timing_file [read $tmp2_file]
close $tmp2_file
```

*Screenshots*

*/tmp/2*

![Screenshot from 2023-08-29 17-25-25](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/0ef0d12c-1add-4504-9fd2-4b805af5a8e1)

*/tmp/3*

![Screenshot from 2023-08-29 17-25-45](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/4e4dcd61-1b03-422f-8ff0-bf6a778e4acc)

###### Converting 'set_input_delay' constraints

Processes 'set_input_delay' constaint part of SDC.

*Code*

```tcl
# Converting set_input_delay constraints
# --------------------------------------
set find_keyword [lsearch -all -inline $lines "set_input_delay*"]
set tmp2_file [open /tmp/2 w]
set new_port_name ""
foreach elem $find_keyword {
        set port_name [lindex $elem [expr {[lsearch $elem "get_ports"]+1}]]
        if {![string match $new_port_name $port_name]} {
                set new_port_name $port_name
        	set delays_list [lsearch -all -inline $find_keyword [join [list "*" " " $port_name " " "*"] ""]]
		set delay_value ""
        	foreach new_elem $delays_list {
        		set port_index [lsearch $new_elem "get_ports"]
        		lappend delay_value [lindex $new_elem [expr {$port_index-1}]]
        	}
        	puts -nonewline $tmp2_file "\nat $port_name $delay_value"
	}
}
close $tmp2_file
set tmp2_file [open /tmp/2 r]
puts -nonewline $timing_file [read $tmp2_file]
close $tmp2_file
```

*Screenshots*

*/tmp/2*

![Screenshot from 2023-08-29 17-27-29](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/b19e68f3-57a1-42d4-90fc-ed2a9e058158)

*/tmp/3*

![Screenshot from 2023-08-29 17-27-43](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/10003b27-2e09-45bf-9bee-da0d0ef6bd50)

###### Converting 'set_input_transition' constraints

Processes 'set_input_transition' constaint part of SDC.

*Code*

```tcl
# Converting set_input_transition constraints
# -------------------------------------------
set find_keyword [lsearch -all -inline $lines "set_input_transition*"]
set tmp2_file [open /tmp/2 w]
set new_port_name ""
foreach elem $find_keyword {
        set port_name [lindex $elem [expr {[lsearch $elem "get_ports"]+1}]]
        if {![string match $new_port_name $port_name]} {
                set new_port_name $port_name
        	set delays_list [lsearch -all -inline $find_keyword [join [list "*" " " $port_name " " "*"] ""]]
        	set delay_value ""
        	foreach new_elem $delays_list {
        		set port_index [lsearch $new_elem "get_ports"]
        		lappend delay_value [lindex $new_elem [expr {$port_index-1}]]
        	}
        	puts -nonewline $tmp2_file "\nslew $port_name $delay_value"
	}
}

close $tmp2_file
set tmp2_file [open /tmp/2 r]
puts -nonewline $timing_file [read $tmp2_file]
close $tmp2_file
```

*Screenshots*

*/tmp/2*

![Screenshot from 2023-08-29 17-29-37](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/956c7538-92c0-49b6-9fce-5cd6d418dd41)

*/tmp/3*

![Screenshot from 2023-08-29 17-29-58](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/da17d4f2-4855-4a23-81fd-566500f29926)

###### Converting 'set_output_delay' constraints

Processes 'set_output_delay' constaint part of SDC.

*Code*

```tcl
# Converting set_output_delay constraints
# ---------------------------------------
set find_keyword [lsearch -all -inline $lines "set_output_delay*"]
set tmp2_file [open /tmp/2 w]
set new_port_name ""
foreach elem $find_keyword {
        set port_name [lindex $elem [expr {[lsearch $elem "get_ports"]+1}]]
        if {![string match $new_port_name $port_name]} {
                set new_port_name $port_name
        	set delays_list [lsearch -all -inline $find_keyword [join [list "*" " " $port_name " " "*"] ""]]
        	set delay_value ""
        	foreach new_elem $delays_list {
        		set port_index [lsearch $new_elem "get_ports"]
        		lappend delay_value [lindex $new_elem [expr {$port_index-1}]]
        	}
        	puts -nonewline $tmp2_file "\nrat $port_name $delay_value"
	}
}

close $tmp2_file
set tmp2_file [open /tmp/2 r]
puts -nonewline $timing_file [read $tmp2_file]
close $tmp2_file
```

*Screenshots*

*/tmp/2*

![Screenshot from 2023-08-29 17-31-42](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/42b174e7-dc05-42ae-ba7e-390986e49f3d)

*/tmp/3*

![Screenshot from 2023-08-29 17-32-11](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/49185da9-2642-4b6a-a24a-c12fc8ef1548)

###### Converting 'set_load' constraints

Processes 'set_load' constaint part of SDC. And with that all SDC constarints are processed and so we close the /tmp/3 file containing all processed data for now.

*Code*

```tcl
# Converting set_load constraints
# -------------------------------
set find_keyword [lsearch -all -inline $lines "set_load*"]
set tmp2_file [open /tmp/2 w]
set new_port_name ""
foreach elem $find_keyword {
        set port_name [lindex $elem [expr {[lsearch $elem "get_ports"]+1}]]
        if {![string match $new_port_name $port_name]} {
                set new_port_name $port_name
        	set delays_list [lsearch -all -inline $find_keyword [join [list "*" " " $port_name " " "*" ] ""]]
        	set delay_value ""
        	foreach new_elem $delays_list {
        	set port_index [lsearch $new_elem "get_ports"]
        	lappend delay_value [lindex $new_elem [expr {$port_index-1}]]
        	}
        	puts -nonewline $timing_file "\nload $port_name $delay_value"
	}
}
close $tmp2_file
set tmp2_file [open /tmp/2 r]
puts -nonewline $timing_file  [read $tmp2_file]
close $tmp2_file

# Closing tmp file after writing constraints converted from generated SDC
close $timing_file
```

*Screenshots*

*/tmp/2*

![Screenshot from 2023-08-29 17-43-58](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/9540204e-8cc1-4438-8cf7-6848f7f1a02a)

*/tmp/3*

![Screenshot from 2023-08-29 17-44-25](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/42b14a5f-3de4-4b02-89b4-c6219cb232f5)

###### Expanding the bussed input and output ports

/tmp/3 file contains bussed ports as <port_name>* which is expanded to it's each bits and single bit ports lines are untouched and this new content is dumped to .timing file and then the proc exits by giving output the OpenTimer command to access this .timing file.

*Code*

```tcl
# Expanding the bussed input and output ports to it's individual bits and writing final .timing file for OpenTimer
set ot_timing_file [open $sdc_dirname/$sdc_filename.timing w]
set timing_file [open /tmp/3 r]
while { [gets $timing_file line] != -1 } {
        if {[regexp -all -- {\*} $line]} {
                set bussed [lindex [lindex [split $line "*"] 0] 1]
                set final_synth_netlist [open $sdc_dirname/$sdc_filename.final.synth.v r]
                while { [gets $final_synth_netlist line2] != -1 } {
                        if {[regexp -all -- $bussed $line2] && [regexp -all -- {input} $line2] && ![string match "" $line]} {

                        	puts -nonewline $ot_timing_file "\n[lindex [lindex [split $line "*"] 0 ] 0 ] [lindex [lindex [split $line2 ";"] 0 ] 1 ] [lindex [split $line "*"] 1 ]"

                        } elseif {[regexp -all -- $bussed $line2] && [regexp -all -- {output} $line2] && ![string match "" $line]} {

                        	puts -nonewline $ot_timing_file "\n[lindex [lindex [split $line "*"] 0 ] 0 ] [lindex [lindex [split $line2 ";"] 0 ] 1 ] [lindex [split $line "*"] 1 ]"

                        }
                }
        } else {
        	puts -nonewline $ot_timing_file  "\n$line"
        }
}
close $timing_file
puts "set_timing_fpath $sdc_dirname/$sdc_filename.timing"

}
```

*Screenshots*

![Screenshot from 2023-08-29 17-49-32](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/7836a33e-dc40-4c7a-bc60-74408ef15260)

*/tmp/3*

![Screenshot from 2023-08-29 17-51-29](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/483ee333-38f4-4047-a2dc-d8e7b9c2c833)

*openMSP430.timing*

![Screenshot from 2023-08-29 17-52-01](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/5c76e83e-6855-4d13-bad8-a662da9ff265)

#### Using the procs to write .conf

I have successfully written the code to use these procs on an application level and create some portion of the .conf configuration file required for OpenTimer tool. The basic code of the same and screenshots of terminal and .conf are shown below.

*Code*

```tcl
# Preparation of .conf for OpenTimer STA
# --------------------------------------
# Procs used below \/
puts "\nInfo: Timing Analysis Started...."
puts "\nInfo: Initializing number of threads, libraries, sdc, verilog netlist path..."
# Sourcing required procs
source /home/vsduser/vsdsynth/procs/reopenStdout.proc
source /home/vsduser/vsdsynth/procs/set_multi_cpu_usage.proc
source /home/vsduser/vsdsynth/procs/read_lib.proc
source /home/vsduser/vsdsynth/procs/read_verilog.proc
source /home/vsduser/vsdsynth/procs/read_sdc.proc
# Writing command required for OpenTimer tool to .conf file by closing and redirecting 'stdout' to a file
reopenStdout $Output_Directory/$Design_Name.conf
set_multi_cpu_usage -localCpu 4
read_lib -early $Early_Library_Path
read_lib -late $Late_Library_Path
read_verilog $Output_Directory/$Design_Name.final.synth.v
read_sdc $Output_Directory/$Design_Name.sdc
# Reopening 'stdout' to bring back screen log
reopenStdout /dev/tty
# Closing .conf file opened by 'reopenStdout' proc
close $Output_Directory/$Design_Name.conf
```

*Screenshots*

![Screenshot from 2023-08-29 18-18-15](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/59692da1-15c3-4f26-9b16-d994df79433f)
![Screenshot from 2023-08-29 18-18-33](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/4265a870-cd60-4061-8f29-c5ac29fbb5f7)
![Screenshot from 2023-08-29 18-18-42](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/29ccd10a-42e5-43aa-9222-f540e08db139)

*openMSP430.conf*

![Screenshot from 2023-08-29 18-19-19](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/da7f3c0c-85aa-4fa0-99fe-d2bcd39b7aa9)

#### Preparation of rest of .conf & .spef files for OpenTimer STA

I have successfully written the code to write .spef *with current date and time in the spef code* and to append rest of the portion of .conf file. The basic code of the same and screenshots of terminal and .conf and .spef are shown below.

*Code*

```tcl
# Preparation of .conf & .spef for OpenTimer STA
# ----------------------------------------------
# Continue to write .conf and also write a .spef
# Writing .spef
set enable_prelayout_timing 1
if {$enable_prelayout_timing == 1} {
	puts "\nInfo: enable_prelayout_timing is $enable_prelayout_timing. Enabling zero-wire load parasitics"
	set spef_file [open $Output_Directory/$Design_Name.spef w]
	puts $spef_file "*SPEF \"IEEE 1481-1998\" "
	puts $spef_file "*DESIGN \"$Design_Name\" "
	puts $spef_file "*DATE \"[clock format [clock seconds] -format {%a %b %d %I:%M:%S %Y}]\" "
	puts $spef_file "*VENDOR \"TAU 2015 Contest\" "
	puts $spef_file "*PROGRAM \"Benchmark Parasitic Generator\" "
	puts $spef_file "*VERSION \"0.0\" "
	puts $spef_file "*DESIGN_FLOW \"NETLIST_TYPE_VERILOG\" "
	puts $spef_file "*DIVIDER / "
	puts $spef_file "*DELIMITER : "
	puts $spef_file "*BUS_DELIMITER \[ \] "
	puts $spef_file "*T_UNIT 1 PS "
	puts $spef_file "*C_UNIT 1 FF "
	puts $spef_file "*R_UNIT 1 KOHM "
	puts $spef_file "*L_UNIT 1 UH "
	close $spef_file
}

# Appending to .conf file
set conf_file [open $Output_Directory/$Design_Name.conf a]
puts $conf_file "set_spef_fpath $Output_Directory/$Design_Name.spef"
puts $conf_file "init_timer "
puts $conf_file "report_timer "
puts $conf_file "report_wns "
puts $conf_file "report_worst_paths -numPaths 10000 "
close $conf_file
```

*Screenshots*

![Screenshot from 2023-08-29 18-47-51](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/f1b2f647-be3e-4efe-a094-8932067b264d)

*openMSP430.spef*

![Screenshot from 2023-08-29 18-49-01](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/6f14f6a6-6a5a-4967-aa8b-bf7f7514a507)

*openMSP430.conf*

![Screenshot from 2023-08-29 19-23-02](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/14233d49-fa1a-43be-95da-4f68e3002c7d)
<!---
![Screenshot from 2023-08-29 18-49-34](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/bc1a6e67-1962-4412-ade9-3519e78efb97)
-->

#### STA using OpenTimer

I have successfully written the code to run STA on OpenTimer and to capture its runtime. The basic code of the same and screenshots of terminal with several "puts" printing out the variables and user debug information are shown below.

*Code*

```tcl
# Static Timing Analysis using OpenTimer
# --------------------------------------
# Running STA on OpenTimer and dumping log to .results and capturing runtime
set tcl_precision 3
set time_elapsed_in_us [time {exec /home/kunalg/Desktop/tools/opentimer/OpenTimer-1.0.5/bin/OpenTimer < $Output_Directory/$Design_Name.conf >& $Output_Directory/$Design_Name.results}]
set time_elapsed_in_sec "[expr {[lindex $time_elapsed_in_us 0]/1000000}]sec"
puts "\nInfo: STA finished in $time_elapsed_in_sec seconds"
puts "\nInfo: Refer to $Output_Directory/$Design_Name.results for warnings and errors"
```

*Screenshots*

![Screenshot from 2023-08-29 19-25-37](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/f1494ffb-bdfb-4e85-bb48-6a323c4babd2)

*openMSP430.results*

![Screenshot from 2023-08-29 19-26-43](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/4e8d4d2b-1f96-4822-9257-58e37a66593f)
<!---
![Screenshot from 2023-08-29 19-00-18](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/32eaa113-437c-40b9-b08e-ca4e1b263acb)
![Screenshot from 2023-08-29 19-00-58](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/094ed944-018c-4428-bc1f-f95cdc425e05)
-->

#### Data collection from .results file and other sources for QoR

I have successfully written the code to collect all required datas to specific codes and *also have collected total .tcl script runtime*. The basic code of the same and screenshots of terminal with several "puts" printing out the variables and user debug information are shown below.

*Code*

```tcl
# Find worst output violation
set worst_RAT_slack "-"
set report_file [open $Output_Directory/$Design_Name.results r]
set pattern {RAT}
while { [gets $report_file line] != -1 } {
	if {[regexp $pattern $line]} {
		set worst_RAT_slack "[expr {[lindex $line 3]/1000}]ns"
		break
	} else {
		continue
	}
}
close $report_file

# Find number of output violation
set report_file [open $Output_Directory/$Design_Name.results r]
set count 0
while { [gets $report_file line] != -1 } {
	incr count [regexp -all -- $pattern $line]
}
set Number_output_violations $count
close $report_file

# Find worst setup violation
set worst_negative_setup_slack "-"
set report_file [open $Output_Directory/$Design_Name.results r]
set pattern {Setup}
while { [gets $report_file line] != -1 } {
	if {[regexp $pattern $line]} {
		set worst_negative_setup_slack "[expr {[lindex $line 3]/1000}]ns"
		break
	} else {
		continue
	}
}
close $report_file

# Find number of setup violation
set report_file [open $Output_Directory/$Design_Name.results r]
set count 0
while { [gets $report_file line] != -1 } {
	incr count [regexp -all -- $pattern $line]
}
set Number_of_setup_violations $count
close $report_file

# Find worst hold violation
set worst_negative_hold_slack "-"
set report_file [open $Output_Directory/$Design_Name.results r]
set pattern {Hold}
while { [gets $report_file line] != -1 } {
	if {[regexp $pattern $line]} { 
		set worst_negative_hold_slack "[expr {[lindex $line 3]/1000}]ns"
		break
	} else {
		continue
	}
}
close $report_file

# Find number of hold violation
set report_file [open $Output_Directory/$Design_Name.results r]
set count 0
while {[gets $report_file line] != -1} {
	incr count [regexp -all - $pattern $line]
}
set Number_of_hold_violations $count
close $report_file

# Find number of instance
set pattern {Num of gates}
set report_file [open $Output_Directory/$Design_Name.results r]
while {[gets $report_file line] != -1} {
	if {[regexp -all -- $pattern $line]} {
		set Instance_count [lindex [join $line " "] 4 ]
		break
	} else {
		continue
	}
}
close $report_file

# Capturing end time of the script
set end_time [clock clicks -microseconds]

# Setting total script runtime to 'time_elapsed_in_sec' variable
set time_elapsed_in_sec "[expr {($end_time-$start_time)/1000000}]sec"
```

*Screenshots*

![Screenshot from 2023-08-29 19-37-06](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/d8186e62-3030-4d0e-a545-887415b77563)

#### QoR (Quality of Results) Generation

I have successfully written the code for QoR generation. The basic code of the same and screenshots of terminal are shown below.

*Code*

```tcl
# Quality of Results (QoR) generation
puts "\n"
puts "                                                           ****PRELAYOUT TIMING RESULTS****\n"
set formatStr {%15s%14s%21s%16s%16s%15s%15s%15s%15s}
puts [format $formatStr "-----------" "-------" "--------------" "---------" "---------" "--------" "--------" "-------" "-------"]
puts [format $formatStr "Design Name" "Runtime" "Instance Count" "WNS Setup" "FEP Setup" "WNS Hold" "FEP Hold" "WNS RAT" "FEP RAT"]
puts [format $formatStr "-----------" "-------" "--------------" "---------" "---------" "--------" "--------" "-------" "-------"]
foreach design_name $Design_Name runtime $time_elapsed_in_sec instance_count $Instance_count wns_setup $worst_negative_setup_slack fep_setup $Number_of_setup_violations wns_hold $worst_negative_hold_slack fep_hold $Number_of_hold_violations wns_rat $worst_RAT_slack fep_rat $Number_output_violations {
	puts [format $formatStr $design_name $runtime $instance_count $wns_setup $fep_setup $wns_hold $fep_hold $wns_rat $fep_rat]
}
puts [format $formatStr "-----------" "-------" "--------------" "---------" "---------" "--------" "--------" "-------" "-------"]
puts "\n"
```

*Screenshots*

![Screenshot from 2023-08-29 19-47-24](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/36f9a31d-56e8-4fdb-9fd1-231bbd11800a)
![Screenshot from 2023-08-29 19-47-53](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/2f937ddf-ef8d-46ea-8e08-15272fab4944)
![Screenshot from 2023-08-29 19-48-16](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/630a39fe-710e-44aa-85d5-29f19e833734)
