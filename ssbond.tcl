#!/usr/bin/tclsh
########################
set out [open bondss6127.dat w]
set num_steps [molinfo top get numframes]
set ca6 [atomselect top "segname LYZ and name CA and resid 6"]
set ca127 [atomselect top "segname LYZ and name CA and resid 127"]
###################################################################
###           MAIN                                             ####
###################################################################
for {set frame 0} {$frame < $num_steps} {incr frame} {
	$ca6 frame $frame
	$ca127 frame $frame
	set dist [vecdist [measure center $ca6] [measure center $ca127]]
	puts $out "$frame $dist"
}
close $out

