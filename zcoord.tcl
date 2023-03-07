set all [atomselect top "all"]
set moup [atomselect top "type MO and z>0"]
set modown [atomselect top "type MO and z<0"]
set num_steps [molinfo top get numframes]
set out [open MOzcoord.dat w]
for {set frame 0} {$frame < $num_steps} {incr frame} {
	$moup frame $frame
#	$modown frame $frame
	$moup update
#	$modown update
#	puts $out "$frame [lindex [measure center $moup] 2] [lindex [measure center $modown] 2]"
	puts $out "$frame [lindex [measure center $moup] 2]"
}
close $out

