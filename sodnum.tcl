#!/usr/bin/tclsh
set out [open out.dat w]
set ttt [atomselect top "(name NAB) and (within 30 of name AU0)"]
set num_steps [molinfo top get numframes]
set sum 0.0

for {set frame 1} {$frame <= $num_steps} {incr frame} {
	$ttt frame $frame
	$ttt update
	set num [$ttt num]
	set sum [expr $sum + $num] 
	set ave [expr $sum/$frame]
	puts $out "$frame $num $ave" 
}
close $out

