#!/usr/bin/tclsh
set num_steps [molinfo top get numframes]
set all [atomselect top "all"]
set n 1
###################################################################
###           MAIN                                             ####
###################################################################
for {set frame 0} {$frame < $num_steps} {incr frame} {
	$all frame $frame
	$all update
	if {[expr $frame+1]%100 == 0} {
		if {$n >= 10} {
			$all writepdb cr233xe_z01c$n.pdb
			incr n
		} else {
			$all writepdb cr233xe_z01c0$n.pdb
			incr n
		}
	}
}
