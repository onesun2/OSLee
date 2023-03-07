#!/usr/bin/tclsh
set out [open temp.dat w]
set num_steps [molinfo top get numframes]
set core [atomselect top "(name C01 to C14) or (name CAY)"]
set all [atomselect top "all"]
set ttt {}
for {set frame 0} {$frame < $num_steps} {incr frame} {
	$core frame $frame
	$core update
	$all frame $frame
	$all update
#	puts $out "$frame, [measure center $core]"
	set xyz [measure center $core]
	set x [lindex $xyz 0]
	set y [lindex $xyz 1]
	lappend ttt [expr -1*$x]
	lappend ttt [expr -1*$y]
	lappend ttt 0.0
	$all moveby $ttt
	set ttt {}
}
close $out
