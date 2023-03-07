set all [atomselect top "all"]
set oh2 [atomselect top "name OH2 and (within 3.4 of name SAM)"]
set od12 [atomselect top "name OD1 OD2 and (within 3.4 of name SAM)"]
set num_steps [molinfo top get numframes]
set out [open nO.dat w]
for {set frame 0} {$frame < $num_steps} {incr frame} {
	$oh2 frame $frame
	$od12 frame $frame
	$oh2 update
	$od12 update

	puts $out "$frame [$oh2 num] [$od12 num] [expr [$oh2 num]+[$od12 num]]"
}
close $out

