set out [open list.dat w]
##### C-Ti 2.18 Å
set cc1 [atomselect top "(segname C00 to C99) or (segname D00 to D99) or (segname E00 to E99) or (segname F00 to F99)"]
foreach i [$cc1 get index] {
	set tiset [atomselect top "(within 2.5 of index $i) and (type TIO)"]
#	puts "$i [$tiset get index]"
	foreach j [$tiset get index] {
		puts $out "$i $j"
	}
}
##################################################################################
##### O-Ti 2.19 Å
set oo1 [atomselect top "(type OX) and ((segname O00 to O99) or (segname P00 to P99) or (segname Q00 to Q99) or (segname R00 to R99))"]
foreach i [$oo1 get index] {
	set tiset [atomselect top "(within 2.5 of index $i) and (type TIO)"]
	foreach j [$tiset get index] {
		puts $out "$i $j"
	}
}
##################################################################################
##### Ti-Ti (same plane) distance 3.07 Å
set ti1 [atomselect top "(segname T00 to T99) or (segname U00 to U99) or (segname V00 to V99) or (segname W00 to W99) or (segname X00 to X99) or (segname Y00 to Y99)"]
foreach i [$ti1 get index] {
	set tiset [atomselect top "(within 3.5 of index $i) and (not (within 3.0 of index $i)) and (type TIO)"]
	foreach j [$tiset get index] {
		puts $out "$i $j"
	}
}
##### C-C (same plane) distance 3.07 Å
set cc1 [atomselect top "(segname C00 to C99) or (segname D00 to D99) or (segname E00 to E99) or (segname F00 to F99)"] 
foreach i [$cc1 get index] {
	set tiset [atomselect top "(within 3.08 of index $i) and (not index $i) and (type CX)"]
	foreach j [$tiset get index] {
		puts $out "$i $j"
	}
}

##### O-O (same plane) distance 3.07 Å
set oo1 [atomselect top "(type OX) and ((segname O00 to O99) or (segname P00 to P99) or (segname Q00 to Q99) or (segname R00 to R99))"]
foreach i [$oo1 get index] {
	set tiset [atomselect top "(within 3.08 of index $i) and (not index $i) and (type OX)"]
	foreach j [$tiset get index] {
		puts $out "$i $j"
	}
}

close $out

