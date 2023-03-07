#!/usr/bin/tclsh
set max 1000000.0
set n 0
for {set i 0 } {$i< $max} {incr i} {
	if {[expr sqrt(pow(rand(),2)+pow(rand(),2))] <= 1.0} {
		incr n
	}
}
puts "pi = [expr 4*$n/$max]"
