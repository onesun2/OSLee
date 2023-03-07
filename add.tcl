#!/usr/bin/tclsh
set add -7368
set f [open [lindex $argv 0] r]
set fileId [open out.dat w]
while {[gets $f line] >= 0} {
	set d0 [lindex $line 0]
	set d1 [lindex $line 1]
	set d2 [lindex $line 2]
	set d3 [lindex $line 3]
	set d4 [lindex $line 4]
	set d5 [lindex $line 5]
	set d6 [lindex $line 6]
	set d7 [lindex $line 7]

	set n0 [expr $d0 + $add]
	set n1 [expr $d1 + $add]
	set n2 [expr $d2 + $add]
	set n3 [expr $d3 + $add]
	set n4 [expr $d4 + $add]
	set n5 [expr $d5 + $add]
	set n6 [expr $d6 + $add]
	set n7 [expr $d7 + $add]

	puts $fileId [format "%8d %7d %7d %7d %7d %7d %7d %7d" $n0 $n1 $n2 $n3 $n4 $n5 $n6 $n7]
}
