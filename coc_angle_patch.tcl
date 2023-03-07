set out [open osangle.out w]
set os [atomselect top "name OS"]
set list1 [$os get index]
for {set i 0} {$i < [$os num]} {incr i} {
	set idx1 [lindex $list1 $i]

	set a1 [atomselect top "index $idx1"]
	set temp2 [$a1 getbonds]
	foreach el [lindex $temp2 0] {
		set idx21 [lindex $temp2 0 0]
		set idx22 [lindex $temp2 0 1]
	}
	set a21 [atomselect top "index $idx21"]
	set a22 [atomselect top "index $idx22"]

	set list31 {}
	set temp31 [$a21 getbonds]

	set list32 {}
	set temp32 [$a22 getbonds]

	foreach el [lindex $temp31 0] {
		if {$el != $idx1 && $el != $idx22} {
			lappend list31 $el
		}
	}

	foreach el [lindex $temp32 0] {
		if {$el != $idx1 && $el != $idx21} {
			lappend list32 $el
		}
	}

	if {[llength $list31] == 1 && [llength $list32] == 1} {
		set idx31 [lindex $list31 0] 
		set idx32 [lindex $list32 0] 

		puts $out "$idx1 $idx21 $idx31"
		puts $out "$idx1 $idx22 $idx32"

		topo addangle $idx1 $idx21 $idx31
		topo addangle $idx1 $idx22 $idx32
	} elseif {[llength $list31] == 2 && [llength $list32] == 2} {
		set idx31a [lindex $list31 0] 
		set idx31b [lindex $list31 1] 
		set idx32a [lindex $list32 0] 
		set idx32b [lindex $list32 1] 

		puts $out "$idx1 $idx21 $idx31a"
		puts $out "$idx1 $idx21 $idx31b"
		puts $out "$idx1 $idx22 $idx32a"
		puts $out "$idx1 $idx22 $idx32b"

		topo addangle $idx1 $idx21 $idx31a
		topo addangle $idx1 $idx21 $idx31b
		topo addangle $idx1 $idx22 $idx32a
		topo addangle $idx1 $idx22 $idx32b
	} elseif {[llength $list31] == 1 && [llength $list32] == 2} {
		set idx31 [lindex $list31 0] 
		set idx32a [lindex $list32 0] 
		set idx32b [lindex $list32 1] 

		puts $out "$idx1 $idx21 $idx31"
		puts $out "$idx1 $idx22 $idx32a"
		puts $out "$idx1 $idx22 $idx32b"

		topo addangle $idx1 $idx21 $idx31
		topo addangle $idx1 $idx22 $idx32a
		topo addangle $idx1 $idx22 $idx32b
	} elseif {[llength $list31] == 2 && [llength $list32] == 1} {
		set idx31a [lindex $list31 0] 
		set idx31b [lindex $list31 1] 
		set idx32 [lindex $list32 0] 

		puts $out "$idx1 $idx21 $idx31a"
		puts $out "$idx1 $idx21 $idx31b"
		puts $out "$idx1 $idx22 $idx32"

		topo addangle $idx1 $idx21 $idx31a
		topo addangle $idx1 $idx21 $idx31b
		topo addangle $idx1 $idx22 $idx32
	}
}
close $out
