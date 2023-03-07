#!/usr/bin/tclsh
set tcl_precision 12
#set sum 0.0
set n 0
set out [open dat.dat w]
set out2 [open time.dat w]
set out3 [open acctime.dat w]
set num_steps [molinfo top get numframes]
#set ttt [atomselect top "(same residue as ((within 4.0 of segname GR1) and (within 4.0 of segname GR2))) and (name O1)"]
set ttt [atomselect top "(name OH2) and (x>=-5 and x<=5) and (y>=-12 and y<=12) and (z>=-9.8 and z<=9.8)"]
set ccc {}
set data {}

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
			set p($i,$frame) 1
		} else {
			set p($i,$frame) 0
		}
	}
}

for {set frame 0} {$frame < $num_steps} {incr frame} {
	foreach i $ccc {
#		puts $out "frame = $frame, p($i,$frame) = $p($i,$frame)"
		puts $out "$p($i,$frame) " nonewline
		if {$frame==0} {
			set sum($i) 0 
		}
		set sum($i) [expr $sum($i)+$p($i,$frame)]
		if {$sum($i)>0 && $p($i,$frame)==0} {
			puts $out2 "sum($i) = $sum($i)"
			lappend data $sum($i)
			set sum($i) 0
		}
	}
	puts $out ""
}

foreach i $data {
	puts $out3 "$i"
}
#puts $out3 "$data"
close $out
close $out2
close $out3
