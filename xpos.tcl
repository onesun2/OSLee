#!/usr/bin/tclsh
package require Tcl 8
package require math::statistics
set out [open distGR.dat w]
set gr1 [atomselect top "(segname GR1) and (type CA)"]
set gr2 [atomselect top "(segname GR2) and (type CA)"]
set gr1x [$gr1 get x]
set gr2x [$gr2 get x]
set ttt {}
set num_steps [molinfo top get numframes]

for {set frame 0} {$frame < $num_steps} {incr frame} {
	$gr1 frame $frame
	$gr2 frame $frame
	$gr1 update
	$gr2 update
	set gr1x [$gr1 get x]
	set gr2x [$gr2 get x]
	set mean1 [::math::statistics::mean $gr1x]
#	set stdev1 [::math::statistics::stdev $gr1x]
	set mean2 [::math::statistics::mean $gr2x]
#	set stdev2 [::math::statistics::stdev $gr2x]
	puts $out "$frame [expr $mean2-$mean1]"	
	lappend ttt [expr $mean2-$mean1]
}
puts $out "#average = [::math::statistics::mean $ttt]"
puts $out "#stdev = [::math::statistics::stdev $ttt]"
set ttt {}
close $out
