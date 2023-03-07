#!/usr/bin/tclsh
package require Tcl 8
package require math::statistics
set ttt {}

set f1 [open [lindex $argv 0] r]
set f2 [open [lindex $argv 1] r]
set f3 [open [lindex $argv 2] r]
set f4 [open [lindex $argv 3] r]
set f5 [open [lindex $argv 4] r]
set out [open out.dat w]
set out2 [open compare.dat w]

for {set number 0} {$number < 2000} {incr number} {
	gets $f1 line1
	gets $f2 line2
	gets $f3 line3
	gets $f4 line4
	gets $f5 line5
	
	set time1 [lindex $line1 0]

	set ene1 [lindex $line1 1]
	set ene2 [lindex $line2 1]
	set ene3 [lindex $line3 1]
	set ene4 [lindex $line4 1]
	set ene5 [lindex $line5 1]

	lappend ttt $ene1
	lappend ttt $ene2
	lappend ttt $ene3
	lappend ttt $ene4
	lappend ttt $ene5
	puts $out "$time1 [::math::statistics::mean $ttt] [::math::statistics::stdev $ttt]"
	puts $out2 "$time1 $ene1 $ene2 $ene3 $ene4 $ene5 [::math::statistics::mean $ttt] "
	set ttt {}
}

close $out2
close $out
close $f5
close $f4
close $f3
close $f2
close $f1
