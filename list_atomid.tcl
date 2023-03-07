set out1 [open list1.dat w]
set out2 [open list2.dat w]
set ttt [atomselect top "type OX CX TIO"]
foreach i [$ttt get index] {
	set atomid($i) [atomselect top "index $i"]
	set isegname [$atomid($i) get segname] 
	set iresid [$atomid($i) get resid]
	set iname [$atomid($i) get name]
#	puts "segname $isegname resid $iresid atomname $iname"
	puts $out1 "set id$i \[ atomid $isegname $iresid $iname \]"

}

foreach i [$ttt get index] {
	set atomid($i) [atomselect top "index $i"]
	set isegname [$atomid($i) get segname] 
	set iresid [$atomid($i) get resid]
	set iname [$atomid($i) get name]
	puts $out2 "lappend grp2 \$id$i"

}

close $out1
close $out2

