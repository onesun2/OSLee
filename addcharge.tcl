#!/usr/bin/tclsh
set chargesum 0.0
set f [open [lindex $argv 0] r]
while {[gets $f line] >= 0} {
	set charge [lindex $line 6]
	set chargesum [expr $chargesum + $charge]
}
puts $chargesum
