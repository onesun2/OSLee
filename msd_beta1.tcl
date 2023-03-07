#!/usr/bin/tclsh
#####################################
## This is a beta version of Mean Square Displacement calculation script for diffusion constant
## based on the Einstein relation.
## by One-Sun Lee
## November 2014, QEERI, Qatar
## 
## <Procedures>
## Load your trajectory of simulation with VMD
## animate goto 0
## pbc unwrap -first now
## source msd.tcl
## <WARNING>
## This script has a serious memory problem. Turn off your internet explorer.
#####################################
set tcl_precision 12
set num_steps [molinfo top get numframes]
set sum 0.0
set out [open data.dat w]
#set ttt [atomselect top "(segname P000 to P099) and (name O1)"]
set ttt [atomselect top "name O1"] ;# selection of atoms that diffuse
set num_particle [$ttt num]	;# number of atoms that selected
set aaa [$ttt get index]	;# list of index of selected atoms

foreach i $aaa {
	set test($i) [atomselect top "index $i"]
}

for {set frame 0} {$frame < $num_steps} {incr frame} {
	$ttt frame $frame
	foreach i $aaa {
		$test($i) frame $frame
	}

	foreach i $aaa {
		set coor($i,$frame) [measure center $test($i)] ;# coordinates of selected atoms at each frame 
	}
}

for {set tau 500} {$tau <= 2500} {incr tau 100} { ;# time interval for Einstein relation 
	foreach i $aaa {			  ;# for each selected atom	
		for {set frame 0} {$frame < [expr $num_steps-$tau]} {incr frame} { ;# simulation time
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
