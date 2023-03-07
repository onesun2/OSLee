#!/usr/bin/tclsh
set fileId [open run2residue.dat w]
set all [atomselect top "all"] 
set hit [atomselect top "name C13 and (x*x + y*y < 39.69) and (z > -20 and z < 20)"]
set num_steps [molinfo top get numframes]

for {set i 1} {$i <= 18} {incr i} {
	set residue($i) 0 
}

for {set frame 0} {$frame <= $num_steps} {incr frame} {
	$all frame $frame
	$hit frame $frame
	$hit update
	
	set residnum [$hit get resid]	
	set num [llength $residnum]

	for {set i 0} {$i < $num} {incr i} {
		set el [lindex $residnum $i]
		set residue($el) 1
	}
#	puts $fileId "frame = $frame"
	for {set j 1} {$j <= 18} {incr j} {
		puts $fileId "$residue($j) " nonewline
	}
	puts $fileId " "
	for {set k 1} {$k <= 18} {incr k} {
		set residue($k) 0
	}

}
close $fileId
#close $fileId2
