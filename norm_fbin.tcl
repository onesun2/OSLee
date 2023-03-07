#!/usr/bin/tclsh
#################################################
#This script is for the bin analysis of numerical data.
#This can be used for floating point number.
#One-Sun Lee
#08Aug2006
#Univ. of Pennsylvania
##################################################
set min -10.0
set max 10.0
set binsize 0.2
set number_of_line 0
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

for {set j $min} {$j < $max} {fincr j $binsize} {
	set bin($j) 0
}
while {[gets $f line] >= 0} {
	set ele [lindex $line 0]

	for {set i $min} {$i < $max} {fincr i $binsize} {
		if {$ele >= $i && $ele < [expr $i+$binsize]} {
			incr bin($i)
		}
	}
	set number_of_line [expr $number_of_line+1]
}
#	puts "number of line $number_of_line"
	set nol [expr $number_of_line*1.0]

for {set k $min} {$k < $max} {fincr k $binsize} {
#	puts "bin([expr ($k+($k+$binsize))/2]) = $bin($k)"
	puts "[expr ($k+($k+$binsize))/2] [expr $bin($k)/$nol]"
}
