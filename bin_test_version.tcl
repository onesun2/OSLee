#!/usr/bin/tclsh
#################################################
#This is a test version for binning a data set
#This script can be used for integer data only
#One-Sun Lee
#26July2006
#Univ. of Pennsylvania
##################################################
set min 0
set max 10
set binsize 2
set f [open [lindex $argv 0] r]

for {set j $min} {$j < $max} {incr j $binsize} {
	set bin($j) 0
}
while {[gets $f line] >= 0} {
	set ele [lindex $line 0]

	for {set i $min} {$i < $max} {incr i $binsize} {
		if {$ele >= $i && $ele < [expr $i+$binsize]} {
			incr bin($i)
		}
	}
}

for {set k $min} {$k < $max} {incr k $binsize} {
	puts "bin([expr ($k+($k+$binsize))/2]) = $bin($k)"
}
