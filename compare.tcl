set ref [atomselect top "all" frame 0]
set compare [atomselect top "all"]
set num_steps [molinfo top get numframes]
set out [open rmsd.dat w]
for {set frame 0} {$frame < $num_steps} {incr frame} {
	$compare frame $frame
	$compare move [measure fit $compare $ref]
	puts $out "$frame [measure rmsd $compare $ref]"
}
close $out

