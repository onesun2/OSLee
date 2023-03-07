#!/usr/bin/tclsh

set num_steps [molinfo top get numframes]
set sod [atomselect top "(name SOD) and (within 30 of index 1465)"]
set fileId [open num_sod.dat w]

for {set frame 0} {$frame < $num_steps} {incr frame} {
	$sod frame $frame	
	$sod update
#	puts $fileId "$frame [$sod num]"
	puts $fileId [format "%5.2f %10.5f" [expr $frame/100.0] [$sod num]]
}
close $fileId
