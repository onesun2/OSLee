set all [atomselect top "all"]
set sam [atomselect top "name LAN"]
set num_steps [molinfo top get numframes]
set out [open coord.dat w]
for {set frame 0} {$frame < $num_steps} {incr frame} {
	$sam frame $frame
	$sam update
	puts $out "$frame [$sam get x]"
}
close $out

