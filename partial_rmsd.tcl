set out [open poutrmsd.dat w]
set all [atomselect top "all"]
set reference [atomselect top "protein and backbone and resid 1 to 100" frame 0]
set compare [atomselect top "protein and backbone and resid 1 to 100"]
set num_steps [molinfo top get numframes]

for {set frame 0} {$frame < $num_steps} {incr frame} {
	$all frame $frame
	$compare frame $frame
	set trans_mat [measure fit $compare $reference]
#	$compare move $trans_mat
	$all move $trans_mat
	puts $out "$frame [measure rmsd $compare $reference]"
}
close $out
