#!/usr/bin/tclsh
#####################################
## You have to do
## animate goto 0
## pbc unwrap -first now
## before submitting this script for Mean Square Displacement calculation for diffusion coefficient
## WARNING
## This script has a serious memory problem. Turn off your internet explorer.
#####################################
set tcl_precision 12
set num_steps [molinfo top get numframes]
set sum 0.0
set out [open data.dat w]
#set ttt [atomselect top "(segname P000 to P099) and (name O1)"]
set ttt [atomselect top "(name O1)"]
set num_particle [$ttt num]
set aaa [$ttt get index]
foreach i $aaa {
	set test($i) [atomselect top "index $i"]
}

for {set frame 0} {$frame < $num_steps} {incr frame} {
	$ttt frame $frame
	foreach i $aaa {
		$test($i) frame $frame
	}

	foreach i $aaa {
		set coor($i,$frame) [measure center $test($i)] 
	}
}

for {set tau 500} {$tau <= 2500} {incr tau 100} {
	foreach i $aaa {
		for {set frame 0} {$frame < [expr $num_steps-$tau]} {incr frame} {
			set rr($i,$frame) [vecdist $coor($i,$frame) $coor($i,[expr $frame+$tau])]
			set rrrr($i,$frame) [expr $rr($i,$frame)*$rr($i,$frame)]
			set sum [expr $sum+$rrrr($i,$frame)]
		}
	}
	puts $out "$tau [expr $sum/($frame+1)/$num_particle]"
	set sum 0.0
	flush stdout
}
close $out
