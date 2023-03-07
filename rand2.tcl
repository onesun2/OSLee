#!/usr/bin/tclsh
for {set i 1} {$i <= 4} {incr i} {
	puts "n$i = [expr 21*rand()]"
}
