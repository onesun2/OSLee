#!/usr/bin/tclsh
package require Tcl 8
package require math::statistics
set allnear {}
set allfar {}
set f [open [lindex $argv 0] r]
set out [open out.dat w]
while {[gets $f line] >= 0} {
	lappend allnear [lindex $line 1]
	lappend allfar [lindex $line 2]
}
puts $out "ave(near) = [::math::statistics::mean $allnear], stdev = [::math::statistics::stdev $allnear]"
puts $out "ave(far) = [::math::statistics::mean $allfar], stdev = [::math::statistics::stdev $allfar]"
puts "ave(near) = [::math::statistics::mean $allnear], stdev = [::math::statistics::stdev $allnear]"
puts "ave(far) = [::math::statistics::mean $allfar], stdev = [::math::statistics::stdev $allfar]"
