set out [open fluc.dat w]
set reference [atomselect top "protein and backbone" frame 0]
set compare [atomselect top "protein and backbone"]
set num_steps [molinfo top get numframes]

for {set frame 0} {$frame < $num_steps} {incr frame} {
	$compare frame $frame
	set trans_mat [measure fit $compare $reference]
	$compare move $trans_mat
#	puts $out "$frame [measure rmsd $compare $reference]"
}
for {set i 1} {$i <291} {incr i} {
	set res($i) [atomselect top "resid $i and name CA"]
	puts $out "$i [measure rmsf $res($i)]"
}
close $out
