#!/usr/bin/tclsh
set out [open size.dat w]
set all [atomselect top "all"]
set num_steps [molinfo top get numframes]
for {set frame 0} {$frame < $num_steps} {incr frame} {
	animate goto $frame
	puts $out "$frame [lindex [pbc get] 0 0]"
}
close $out

