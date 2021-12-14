#!/usr/bin/tclsh

set count_ram 0
set word 0
set title [ list "Netlist" "ram/dsp inst" "count" ]
set data [ list "--"  "--" "--" ]
#set design_t "ec_design_tests/design_tests_synthesized"
#set flow "SynplifyPro_2012.09/LiberoIDE_v9.2"
#set design "Axcelerator/std/microsemi"
set result_file ""
set flag 0

proc counter {} {
	global title
	global data
	global flow
	global design
	global result_file
	global design_t
	puts $title
	set word "RAM64K36"
	set result_file  [ open "$word.csv" a+ ]
	puts $result_file [join $title "," ]
	set f [ exec find "/home/test_data/extern/testsuite/$design_t/$flow/$design" -name "*.vm" ]
	foreach netlist $f {
		set name [split $netlist "/"]
		set m [ join [lrange $name 11 end-1] "/"]
		puts $name 
		puts $m
		catch {
			info_search $m $netlist $word $title
		}
	}
}

proc info_search {m netlist word title} {
	global data
	global result_file
	set count_ram [ exec grep -H $word $netlist | wc -l ]
	lset data 0 $m
	lset data 1 $word 
	lset data 2 $count_ram
	#puts $netlist  
	#puts $title
	puts $result_file [join $data "," ]
}

counter 
