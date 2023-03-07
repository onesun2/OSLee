#!/usr/bin/tclsh
package require Tcl 8
package require math::statistics

set out1 [open temp.dat w]
set num_steps [molinfo top get numframes]

set all [atomselect top "all"]
set z01p [atomselect top "name OH2 and z>1.0 and z<2.0"]
set z01p_s {}

for {set frame 0} {$frame < $num_steps} {incr frame} {
	$all frame $frame
	$z01p frame $frame

	$z01p update
	lappend z01p_s [$z01p num]
	puts $out1 "$frame [$z01p num]"
}
puts $out1 "avg [::math::statistics::mean $z01p_s], stdev [::math::statistics::stdev $z01p_s]"
close $out1

