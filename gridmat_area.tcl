#!/usr/bin/tclsh
package require math::statistics
set toparea {}
set out [open log.dat w]

for {set i 1} {$i <= 200} {incr i} {
	set f1 [open ./output/output.frame$i.20x20.top_areas.dat r]
	for {set linenumber 0} {$linenumber <1} {incr linenumber} {
		gets $f1 line1
		set area [lindex $line1 3]
#		puts $out "top frame $i, area = $area"
		puts $out "$i $area"
		lappend toparea $area
	}	
	close $f1
}
puts $out "ave(top) = [::math::statistics::mean $toparea], stdev = [::math::statistics::stdev $toparea]"
set toparea {}
close $out

