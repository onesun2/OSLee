#!/usr/bin/tclsh
set fileId1 [open da.dat w]

set f1 [open da_smd_tcl1.out r]
set f2 [open da_smd_tcl2.out r]
set f3 [open da_smd_tcl3.out r]
set f4 [open da_smd_tcl4.out r]
set f5 [open da_smd_tcl5.out r]

for {set number 0} {$number <= 50000} {incr number} {
	gets $f1 line1
	gets $f2 line2
	gets $f3 line3
	gets $f4 line4
	gets $f5 line5

	set time1 [lindex $line1 0]

	set dist1 [lindex $line1 1]
	set force1 [lindex $line1 2]

	set dist2 [lindex $line2 1]
	set force2 [lindex $line2 2]

	set dist3 [lindex $line3 1]
	set force3 [lindex $line3 2]

	set dist4 [lindex $line4 1]
	set force4 [lindex $line4 2]

	set dist5 [lindex $line5 1]
	set force5 [lindex $line5 2]

	puts $fileId1 [format "%10.3f %15.9f %15.9f %15.9f %15.9f %15.9f %15.9f %15.9f %15.9f %15.9f %15.9f" $time1 $dist1 $dist2 $dist3 $dist4 $dist5 $force1 $force2 $force3 $force4 $force5]
}
close $fileId1
