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

In my command ***yosysui*** I have implemented a total of 5 general scenarios from user point of view in the bash script.

**1. No input file provided**

![Screenshot from 2023-08-24 19-39-50](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/cb679d28-e0de-448a-ad2a-5d31031d2f8b)

**2. File provided exists but is not of .csv format**

![Screenshot from 2023-08-24 19-41-41](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/45653ab6-96be-49f1-8af2-afcce1ee0392)

**3. More than one file or parameters provided**

![Screenshot from 2023-08-24 19-53-06](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/8ad5345c-1fa8-4432-b618-b5a0bd5f3934)

**4. Provide a .csv file that does not exist**

![Screenshot from 2023-08-24 19-54-26](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/96ee26cd-43ed-4056-a1ac-c42a5207542a)

**5. Type "-help" to find out usage**

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

**Variable Creation**

I have auto created the variables (have used special condition to identify design name) from the csv file by converting it into a matrix and then to an array. The basic code of the same and screenshot of terminal with several "puts" printing out the variables are shown below.

*Code*

```tcl
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

**File / Directory Existance Check**

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

**Processing of the constraints openMSP430_design_constraints.csv file**

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

**Processing of the constraints .csv file for CLOCKS and dumping SDC commands to .sdc**

I have successfully processed the csv file for CLOCKS data and dumped clock based SDC commands to .sdc file.  The basic code of the same and screenshots of terminal with several "puts" printing out the variables and user debug information as well as output .sdc  are shown below.

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
