#!/usr/bin/tclsh
set out1 [open temp.dat w]
set num_steps [molinfo top get numframes]

set core [atomselect top "(name C01 to C14) or (name CAY)"]
set w50 [atomselect top "name OH2 and x*x+y*y< 2500"]
set all [atomselect top "all"]
set ttt {}

for {set frame 0} {$frame < $num_steps} {incr frame} {
	$core frame $frame
	$all frame $frame
	$w50 frame $frame

	set xyz [measure center $core]

	set x [lindex $xyz 0]
	set y [lindex $xyz 1]
	set z [lindex $xyz 2]

	lappend ttt [expr -1*$x]
	lappend ttt [expr -1*$y]
	lappend ttt 0.0

	$all moveby $ttt

	$core update
	$w50 update

	puts $out1 "$frame [$w50 num]"
	set ttt {}
}
close $out1
