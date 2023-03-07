#!/usr/bin/tclsh
#set num_frames [molinfo $gr_mol get numframes]
package require Tcl 8
package require math::statistics
set ttt {}
set hsum 0.0
set f [open [lindex $argv 0] r]
set out [open out.dat w]
while {[gets $f line] >= 0} {
	set htime [lindex $line 0]
	set hreal [expr 500*$htime/100.0] ;# total number of frame 500, %/100
	lappend ttt $hreal
}
puts $out "[::math::statistics::mean $ttt] +/- [::math::statistics::stdev $ttt]"
puts "[::math::statistics::mean $ttt] +/- [::math::statistics::stdev $ttt]"
close $out

