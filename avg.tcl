#!/usr/bin/tclsh
package require Tcl 8
package require math::statistics
set f [open [lindex $argv 0] r]
set ttt {}

while {[gets $f line] >= 0} {
        set ele [lindex $line 1]
	lappend ttt $ele
}

puts "avg = [::math::statistics::mean $ttt], stdev = [::math::statistics::stdev $ttt]"
set ttt {} 
close $f
