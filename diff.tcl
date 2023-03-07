#!/usr/bin/tclsh
#script for diffusion coefficient calculation
set tcl_precision 12
set sum 0.0
set n 0
set out [open dat.dat w]
set num_steps [molinfo top get numframes]
set ttt [atomselect top "name OH2"]
set ccc {}

for {set frame 0} {$frame < $num_steps} {incr frame} {
	$ttt frame $frame
	$ttt update
	set olist($frame) [$ttt get index] 
#	puts $out "olist($frame) $olist($frame)"
}

for {set frame 0} {$frame < $num_steps} {incr frame} {
	foreach i $olist($frame) {
		if {[lsearch $ccc $i]<0} {
			lappend ccc [lindex $olist($frame) [lsearch $olist($frame) $i]]
		}
	}
}

for {set frame 0} {$frame < $num_steps} {incr frame} {
	foreach i $ccc {
		if {[lsearch $olist($frame) $i] >=0} {
			set pp($i,$frame) 1
		} else {
			set pp($i,$frame) 0
		}
	}
}

foreach i $ccc {
	set test($i) [atomselect top "index $i"]
}
for {set frame 0} {$frame < $num_steps} {incr frame} {
	$ttt frame $frame
	foreach i $ccc {
		$test($i) frame $frame
	}

	foreach i $ccc {
		set coor($i,$frame) [measure center $test($i)]
	}
}

for {set tau 500} {$tau <= 2500} {incr tau 100} {
	foreach i $ccc {
		for {set frame 0} {$frame < [expr $num_steps-$tau]} {incr frame} {
			if {[expr $pp($i,$frame)*$pp($i,[expr $frame+$tau])]==1} {
				set rr($i,$frame) [vecdist $coor($i,$frame) $coor($i,[expr $frame+$tau])]
				set rrrr($i,$frame) [expr $rr($i,$frame)*$rr($i,$frame)]
				set sum [expr $sum+$rrrr($i,$frame)]
				set n [expr $n+1]
			}
		}
	}
#	puts $out "$tau [expr $sum/($frame+1)/[llength $ccc]]"
	puts $out "$tau [expr $sum/$n]"
	set sum 0.0
	set n 0
}

#for {set frame 0} {$frame < $num_steps} {incr frame} {
#	puts $out "p(410,$frame) = $p(410,$frame)"
#	puts $out "coor(410,$frame) = $coor(410,$frame)"
#}
close $out

