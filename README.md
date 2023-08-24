![Yosys_TCL_UI](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/970d192f-4eee-40b2-b285-51ce1c663677)
# Yosys TCL UI

5 Day TCL training workshop by VSD using Yosys and Opentimer open-source eda tools and TCL to generate a report from a design wherein the input is design file paths in .csv format to the tcl program. The final objective by day 5 is to give design details namely paths of design data to the "TCL BOX" which is the UI being designed which runs the design in Yosys and Opentimer open-source eda tools and returns a report of the design.

![Screenshot (264)](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/dcf3a9f9-2281-4d6f-b318-a52ddea1fb7d)
![Screenshot (265)](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/6194ce14-1cf5-41c2-9de3-6938f205f912)

## Day 1 - Introduction to TCL and VSDSYNTH Toolbox Usage (23/08/2023)

Day 1 task is to create command (in my case ***yosysui***) and pass .csv file from UNIX shell to TCL script taking into consideration mainly 3 general scenarios from user point of view.

![Screenshot 2023-08-24 183526](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/a1c31fb3-a8e5-4a7e-987d-3d7e6ff4ad65)

**Review of input file provided in work directory**

![Screenshot from 2023-08-23 22-48-19](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/7dd31089-d1a4-44a2-9d31-f828af25e37c)

**Review of input openMSP430_design_details.csv file**

![Screenshot from 2023-08-23 22-29-25](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/de69f8ea-92cc-40e6-b570-e7a364c72c04)

**Review of input openMSP430_design_constraints.csv file**

![Screenshot from 2023-08-23 22-51-48](https://github.com/fayizferosh/yosys-tcl-ui-report/assets/63997454/c72f9e71-4650-4ead-bb66-d5a1d9cdd53d)

### Implementation

In my command ***yosysui*** I have implemented a total of 5 general scenarios from user point of view in a bash script.

**1. No input file provided**

**2. File provided exists but is not of .csv format**

**3. More than one file or parameters provided**

**4. Provide a .csv file that does not exist**

**5. Type "-help" to find out usage**
