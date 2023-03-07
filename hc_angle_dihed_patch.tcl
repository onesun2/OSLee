
set h1 [atomselect top "name H1"]
set list1 [$h1 get index]
set out [open hc_dihedral.out w]
set out2 [open hc_angle.out w]

for {set i 0} {$i < [$h1 num]} {incr i} {
	set idx1 [lindex $list1 $i]
	set a1 [atomselect top "index $idx1"]
	set idx2 [$a1 getbonds]
	set a2 [atomselect top "index $idx2"]
	set temp3 [$a2 getbonds]
	set list3 {}

	foreach el [lindex $temp3 0] {
		if {$el != $idx1} {
			lappend list3 $el
		}
	}

	if {[llength $list3] == 2} {
		set idx31 [lindex $list3 0]
		set idx32 [lindex $list3 1]
		puts $out2 "$idx1 $idx2 $idx31"
		puts $out2 "$idx1 $idx2 $idx32"

		topo addangle $idx1 $idx2 $idx31
		topo addangle $idx1 $idx2 $idx32

		set a31 [atomselect top "index $idx31"]	
		set temp41 [$a31 getbonds]
		set list41 {}
		foreach el [lindex $temp41 0] {
			if {$el != $idx2} {
				lappend list41 $el
			}
		}
		if {[llength $list41] == 1} {
			set idx411 [lindex $list41 0]
			puts $out "$idx1 $idx2 $idx31 $idx411"
			topo adddihedral $idx1 $idx2 $idx31 $idx411
		} elseif {[llength $list41] == 2} {
			set idx411 [lindex $list41 0]
			set idx412 [lindex $list41 1]

			puts $out "$idx1 $idx2 $idx31 $idx411"
			puts $out "$idx1 $idx2 $idx31 $idx412"
			topo adddihedral $idx1 $idx2 $idx31 $idx411
			topo adddihedral $idx1 $idx2 $idx31 $idx412
		} elseif {[llength $list41] == 3} {
			set idx411 [lindex $list41 0]
			set idx412 [lindex $list41 1]
			set idx413 [lindex $list41 2]

			puts $out "$idx1 $idx2 $idx31 $idx411"
			puts $out "$idx1 $idx2 $idx31 $idx412"
			puts $out "$idx1 $idx2 $idx31 $idx413"
			topo adddihedral $idx1 $idx2 $idx31 $idx411
			topo adddihedral $idx1 $idx2 $idx31 $idx412
			topo adddihedral $idx1 $idx2 $idx31 $idx413
		}

		set a32 [atomselect top "index $idx32"]	
		set temp42 [$a32 getbonds]
		set list42 {}
		foreach el [lindex $temp42 0] {
			if {$el != $idx2} {
				lappend list42 $el
			}
		}
		if {[llength $list42] == 1} {
			set idx421 [lindex $list42 0]
			puts $out "$idx1 $idx2 $idx32 $idx421"
			topo adddihedral $idx1 $idx2 $idx32 $idx421
		} elseif {[llength $list42] == 2} {
			set idx421 [lindex $list42 0]
			set idx422 [lindex $list42 1]

			puts $out "$idx1 $idx2 $idx32 $idx421"
			puts $out "$idx1 $idx2 $idx32 $idx422"
			topo adddihedral $idx1 $idx2 $idx32 $idx421
			topo adddihedral $idx1 $idx2 $idx32 $idx422
		} elseif {[llength $list42] == 3} {
			set idx421 [lindex $list42 0]
			set idx422 [lindex $list42 1]
			set idx423 [lindex $list42 2]

			puts $out "$idx1 $idx2 $idx32 $idx421"
			puts $out "$idx1 $idx2 $idx32 $idx422"
			puts $out "$idx1 $idx2 $idx32 $idx423"
			topo adddihedral $idx1 $idx2 $idx32 $idx421
			topo adddihedral $idx1 $idx2 $idx32 $idx422
			topo adddihedral $idx1 $idx2 $idx32 $idx423
		}

	} elseif {[llength $list3] == 3} {
		set idx31 [lindex $list3 0]
		set idx32 [lindex $list3 1]
		set idx33 [lindex $list3 2]

		puts $out2 "$idx1 $idx2 $idx31"
		puts $out2 "$idx1 $idx2 $idx32"
		puts $out2 "$idx1 $idx2 $idx33"

		topo addangle $idx1 $idx2 $idx31
		topo addangle $idx1 $idx2 $idx32
		topo addangle $idx1 $idx2 $idx33

		set a31 [atomselect top "index $idx31"]	
		set temp41 [$a31 getbonds]
		set list41 {}
		foreach el [lindex $temp41 0] {
			if {$el != $idx2} {
				lappend list41 $el
			}
		}
		if {[llength $list41] == 1} {
			set idx411 [lindex $list41 0]
			puts $out "$idx1 $idx2 $idx31 $idx411"
			topo adddihedral $idx1 $idx2 $idx31 $idx411
		} elseif {[llength $list41] == 2} {
			set idx411 [lindex $list41 0]
			set idx412 [lindex $list41 1]

			puts $out "$idx1 $idx2 $idx31 $idx411"
			puts $out "$idx1 $idx2 $idx31 $idx412"
			topo adddihedral $idx1 $idx2 $idx31 $idx411
			topo adddihedral $idx1 $idx2 $idx31 $idx412
		} elseif {[llength $list41] == 3} {
			set idx411 [lindex $list41 0]
			set idx412 [lindex $list41 1]
			set idx413 [lindex $list41 2]

			puts $out "$idx1 $idx2 $idx31 $idx411"
			puts $out "$idx1 $idx2 $idx31 $idx412"
			puts $out "$idx1 $idx2 $idx31 $idx413"
			topo adddihedral $idx1 $idx2 $idx31 $idx411
			topo adddihedral $idx1 $idx2 $idx31 $idx412
			topo adddihedral $idx1 $idx2 $idx31 $idx413
		}

		set a32 [atomselect top "index $idx32"]	
		set temp42 [$a32 getbonds]
		set list42 {}
		foreach el [lindex $temp42 0] {
			if {$el != $idx2} {
				lappend list42 $el
			}
		}
		if {[llength $list42] == 1} {
			set idx421 [lindex $list42 0]
			puts $out "$idx1 $idx2 $idx32 $idx421"
			topo adddihedral $idx1 $idx2 $idx32 $idx421
		} elseif {[llength $list42] == 2} {
			set idx421 [lindex $list42 0]
			set idx422 [lindex $list42 1]

			puts $out "$idx1 $idx2 $idx32 $idx421"
			puts $out "$idx1 $idx2 $idx32 $idx422"
			topo adddihedral $idx1 $idx2 $idx32 $idx421
			topo adddihedral $idx1 $idx2 $idx32 $idx422
		} elseif {[llength $list42] == 3} {
			set idx421 [lindex $list42 0]
			set idx422 [lindex $list42 1]
			set idx423 [lindex $list42 2]

			puts $out "$idx1 $idx2 $idx32 $idx421"
			puts $out "$idx1 $idx2 $idx32 $idx422"
			puts $out "$idx1 $idx2 $idx32 $idx423"
			topo adddihedral $idx1 $idx2 $idx32 $idx421
			topo adddihedral $idx1 $idx2 $idx32 $idx422
			topo adddihedral $idx1 $idx2 $idx32 $idx423
		}


		set a33 [atomselect top "index $idx33"]	
		set temp43 [$a33 getbonds]
		set list43 {}
		foreach el [lindex $temp43 0] {
			if {$el != $idx2} {
				lappend list43 $el
			}
		}
		if {[llength $list43] == 1} {
			set idx431 [lindex $list43 0]
			puts $out "$idx1 $idx2 $idx33 $idx431"
			topo adddihedral $idx1 $idx2 $idx33 $idx431
		} elseif {[llength $list43] == 2} {
			set idx431 [lindex $list43 0]
			set idx432 [lindex $list43 1]

			puts $out "$idx1 $idx2 $idx33 $idx431"
			puts $out "$idx1 $idx2 $idx33 $idx432"
			topo adddihedral $idx1 $idx2 $idx33 $idx431
			topo adddihedral $idx1 $idx2 $idx33 $idx432
		} elseif {[llength $list43] == 3} {
			set idx431 [lindex $list43 0]
			set idx432 [lindex $list43 1]
			set idx433 [lindex $list43 2]

			puts $out "$idx1 $idx2 $idx33 $idx431"
			puts $out "$idx1 $idx2 $idx33 $idx432"
			puts $out "$idx1 $idx2 $idx33 $idx433"
			topo adddihedral $idx1 $idx2 $idx33 $idx431
			topo adddihedral $idx1 $idx2 $idx33 $idx432
			topo adddihedral $idx1 $idx2 $idx33 $idx433
		}
	}
}
close $out
close $out2
