#!/usr/bin/tclsh
set filename "10side_dist_d20info.txt"
set fileId [open $filename "w"]
set filename2 "10zside20.txt"
set fileId2 [open $filename2 "w"]
set all [atomselect top "all"] 
set hit [atomselect top "name C13 and (x*x + y*y < 36) and (z > -20 and z < 20)"]
set zzz {}
set residset {}
set num_steps [molinfo top get numframes]

#for {set frame 0} {$frame < $num_steps} {incr frame} {
for {set frame 9001} {$frame <= 10000} {incr frame} {
	$all frame $frame
	$hit frame $frame
	$hit update
	
	set residnum [$hit get resid]	
	set zcoor [$hit get z]
	set num [llength $residnum]

	if {$num != 0} {
		puts $fileId "frame = $frame"
		for {set i 0} {$i < $num} {incr i} {
			set el [lindex $residnum $i]
			set z  [lindex $zcoor $i]
			puts $fileId2 "$z"
			puts $fileId "resid: $el, z = $z"
		}
	}
}
close $fileId
close $fileId2
