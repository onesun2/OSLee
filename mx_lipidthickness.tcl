#!/usr/bin/tclsh
package require Tcl 8
package require math::statistics
########################
set out [open mxthickness.dat w]
set num_steps [molinfo top get numframes]
set tttnear {}
set tttfar {}
set tt2 {}
set nearthickness {}
set farthickness {}
set pupper1 [atomselect top "(name P) and (resid 1 to 70) and (within 10 of type TIO)"]
set pupper2 [atomselect top "(name P) and (resid 1 to 70) and (not (within 10 of type TIO))"]
set plower [atomselect top "(name P) and (resid 71 to 140)"]

###################################################################
###           MAIN                                             ####
###################################################################
for {set frame 0} {$frame < $num_steps} {incr frame} {
	$pupper1 frame $frame
	$pupper2 frame $frame
	$plower frame $frame
	$pupper1 update
	$pupper2 update
	$plower update

#	puts $out "number of near P = [$pupper1 num]"
#	puts $out "number of far P = [$pupper2 num]"
	foreach i [$pupper1 get resid] {
	        lappend tttnear [lindex [$pupper1 get z] $i]
	}
#	puts $out "$frame, resid [$pupper1 get resid]"
	set avz1 [::math::statistics::mean $tttnear]

	foreach i [$pupper2 get resid] {
	        lappend tttfar [lindex [$pupper2 get z] $i]
	}
	set avzfar [::math::statistics::mean $tttfar]


	for {set i 0} {$i < 70} {incr i} {
	        lappend tt2 [lindex [$plower get z] $i]
	}
	set avz2 [::math::statistics::mean $tt2]

#	puts $out "$frame [expr $avz1-$avz2]"
	lappend nearthickness [expr $avz1-$avz2]
	lappend farthickness [expr $avzfar-$avz2]
	set tttnear {}
	set tttfar {}
	set tt2 {}
}
set tttnear {} 
set tttfar {} 
set tt2 {}
puts "thickness near Mx ave = [::math::statistics::mean $nearthickness], stdev = [::math::statistics::stdev $nearthickness]"
puts $out "thickness near Mx ave = [::math::statistics::mean $nearthickness], stdev = [::math::statistics::stdev $nearthickness]"
puts "thickness far Mx ave = [::math::statistics::mean $farthickness], stdev = [::math::statistics::stdev $farthickness]"
puts $out "thickness far Mx ave = [::math::statistics::mean $farthickness], stdev = [::math::statistics::stdev $farthickness]"
close $out

