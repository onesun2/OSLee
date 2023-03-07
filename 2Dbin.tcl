#!/usr/bin/tclsh
#################################################
#This script can be used for floating point number data
#One-Sun Lee
#08Aug2006
#Univ. of Pennsylvania
##################################################
set min1 0
set max1 5
set binsize1 0.1
set min2 0
set max2 180
set binsize2 2.0
set f [open [lindex $argv 0] r]
######################################################
#fincr is a floating point version of standard incr ##
######################################################
proc fincr {varName {amount $binsize}} {
	upvar $varName var
	if [info exist var] {
		set var [expr $var + $amount]
	} else {
		set var $amount
	}
	return $var
}
######################################################

for {set j $min1} {$j < $max1} {fincr j $binsize1} {
	for {set k $min2} {$k < $max2} {fincr k $binsize2} {
		set bin($j,$k) 0
#		puts "bin($j,$k)"
	}
}
while {[gets $f line] >= 0} {
	set ele1 [lindex $line 0]
	set ele2 [lindex $line 1]

	for {set i $min1} {$i < $max1} {fincr i $binsize1} {
		for {set j $min2} {$j < $max2} {fincr j $binsize2} {
			if {$ele1 >= $i && $ele1 < [expr $i+$binsize1] && $ele2 >= $j && $ele2 < [expr $j+$binsize2]} {
				incr bin($i,$j)
			}
		}
	}
}

for {set k $min1} {$k < $max1} {fincr k $binsize1} {
	for {set j $min2} {$j < $max2} {fincr j $binsize2} {
		puts "[expr ($k+($k+$binsize1))/2], [expr ($j+($j+$binsize2))/2]; bin([expr ($k+($k+$binsize1))/2],[expr ($j+($j+$binsize2))/2]) = $bin($k,$j)"
	}
}
