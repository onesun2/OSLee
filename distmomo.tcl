#!/usr/bin/tclsh
set out [open momodist.dat w]
set mo1 [atomselect top "type MO and z>0"]
set mo2 [atomselect top "type MO and z<0"]
set num_steps [molinfo top get numframes]
###################################################################
###           MAIN                                             ####
###################################################################
for {set frame 0} {$frame < $num_steps} {incr frame} {
	$mo1 frame $frame
	$mo2 frame $frame
	$mo1 update
	$mo2 update
	puts $out "$frame [expr [lindex [measure center $mo1] 2]-[lindex [measure center $mo2] 2]]"
}
close $out

