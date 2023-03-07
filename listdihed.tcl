
set hh [atomselect top "name HH"]
set list1 [$hh get index]
set out [open data.out w]
for {set i 0} {$i < [$hh num]} {incr i} {
	set idx1 [lindex $list1 $i]
	set a1 [atomselect top "index $idx1"]
	set idx2 [$a1 getbonds]
	set a2 [atomselect top "index $idx2"]
	set temp3 [$a2 getbonds]

	foreach el [lindex $temp3 0] {
		if {$el != $idx1} {
			set idx3 $el
		}
	}

	set a3 [atomselect top "index $idx3"]
	set temp4 [$a3 getbonds]
	set list4 {} 
	foreach el [lindex $temp4 0] {
		if {$el != $idx2} {
			lappend list4 $el
		}
	}
	#puts $list4
	if {[llength $list4] == 2} {
		set idx40 [lindex $list4 0]
		set idx41 [lindex $list4 1]

		puts $out "dih1 $idx1 $idx2 $idx3 $idx40"
		puts $out "dih2 $idx1 $idx2 $idx3 $idx41"
	} elseif {[llength $list4] == 3} {
		set idx40 [lindex $list4 0]
		set idx41 [lindex $list4 1]
		set idx42 [lindex $list4 2]

		puts $out "dih1 $idx1 $idx2 $idx3 $idx40"
		puts $out "dih2 $idx1 $idx2 $idx3 $idx41"
		puts $out "dih3 $idx1 $idx2 $idx3 $idx42"
	}
}
close $out
