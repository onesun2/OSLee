#!/usr/bin/tclsh
set ttt {{0 0 0} {1 1 1} {2 0 0} {3 0 0}}
foreach i $ttt {
	set length [llength $ttt]
	for {set j 0} {$j <= [expr $length-1]} {incr j} {
		set posi [lsearch $ttt $i]
		if {$posi < $j} {
			set sub [vecdist $i [lindex $ttt $j]]
			puts "i = $i, [lindex $ttt $j], $sub"
		}
	}
}
