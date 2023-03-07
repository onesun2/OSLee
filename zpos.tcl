#!/usr/bin/tclsh
set num_steps [molinfo top get numframes]
set out [open data.dat w]
set ccc [atomselect top "(segname GR2) and (resid 3) and (name C11 C32)"]

for {set frame 0} {$frame < $num_steps} {incr frame} {
	$ccc frame $frame
	set xyz [measure center $ccc]
	if {$frame == 0} {
		set z0 [lindex [measure center $ccc] 2]
	}
	puts $out "$frame [expr [lindex $xyz 2]-$z0]"
}
close $out

