#!/usr/bin/tclsh
set out [open dat.dat w]
set aaa {1 2 3 4 5 6 7 8 9 10 11 12}
set bbb {4 5 6 7}

foreach i $aaa {
	if {[lsearch $bbb $i]<0} {
		puts $out "no"
	} else {
		puts $out "[lindex $bbb [lsearch $bbb $i]]"
	}
}
close $out

