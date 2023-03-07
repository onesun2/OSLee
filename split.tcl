#!/usr/bin/tclsh
for {set i 0} {$i <= 7} {incr i} {
	set n 0
	set f [open [lindex $argv 0] r]
	set fileId1 [open craxe${i}Arun02.dat "w"]
	while {[gets $f line] >= 0} {
		set time [lindex $line 0]
		set dist [lindex $line 1]
		set force [lindex $line 2]
		if {$n >= [expr 50000*$i] && $n <= [expr 50000*$i + 50000]} {
			puts $fileId1 [format "%8.3f %15.9f %15.9f" $time $dist $force]
		} 
		incr n
	}
	close $fileId1
}
