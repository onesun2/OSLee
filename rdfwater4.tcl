#!/usr/bin/tclsh
package require Tcl 8
package require math::statistics
set out1 [open test3.dat w]
set out2 [open list3.dat w]
set pi 3.1415926535897931
set num_steps [molinfo top get numframes]

for {set i 0} {$i <= 500} {incr i} {
	set w_list($i) {}
}

for {set i 0} {$i <= 500} {incr i 2} {
	set j [expr $i/10.0]
	set in [expr $j*$j]
	set out [expr ($j+0.2)*($j+0.2)]
	set wat($i) [atomselect top "name OH2 and ((x*x+y*y>= $in) and (x*x+y*y<$out))"]
#	set wat($i) [atomselect top "name OH2 and (x*x+y*y<$i*$i)"]
}

for {set frame 0} {$frame < $num_steps} {incr frame} {
	for {set i 0} {$i <= 500} {incr i 2} {
		$wat($i) frame $frame
	}
	
	for {set i 0} {$i <= 500} {incr i 2} {
		$wat($i) update 
		lappend w_list($i) [$wat($i) num]
	}
}

for {set i 0} {$i <= 500} {incr i 2} {
	set j [expr $i/10.0]
	set vol [expr $pi*75*(($j+0.2)*($j+0.2)-$j*$j)]
	puts $out1 [format "%10.5f %10.5f %10.5f" $j [expr [::math::statistics::mean $w_list($i)]/$vol] [expr [::math::statistics::stdev $w_list($i)]/$vol]]
	puts $out2 "w_list($i) = $w_list($i)"
}
close $out1
close $out2
