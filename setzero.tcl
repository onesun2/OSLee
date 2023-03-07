#!/usr/bin/tclsh
set ttt [atomselect top "resname DPPC"]
set all [atomselect top "all"]
set num_steps [molinfo top get numframes]

for {set frame 0} {$frame < $num_steps} {incr frame} {
	$ttt frame $frame
	$all frame $frame
	$all moveby [vecinvert [measure center $ttt]]
}

