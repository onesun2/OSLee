#!/usr/bin/tclsh
set num_steps [molinfo top get numframes]
set all [atomselect top "all"]
set n 1
set start 30
###################################################################
###           MAIN                                             ####
###################################################################
for {set frame 0} {$frame < $num_steps} {incr frame} {
	$all frame $frame
	$all update
	if {[expr $frame+1]%100 == 0} {
		if {$n >= 10 || $start != 0} {
			$all writepdb crexe_z02c[expr $n+$start].pdb
			incr n
		} else {
			$all writepdb crexe_z02c0[expr $n+$start].pdb
			incr n
		}
	}
}
