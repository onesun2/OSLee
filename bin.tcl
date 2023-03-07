#!/usr/bin/tclsh
###################
#variables#########
###################
set min -200
set max 200
set binsize 10.000
###################
set lista {}
set f [open [lindex $argv 0] r]
while {[gets $f line] >= 0} {
	lappend lista $line
}

for {set k $min} {$k <= $max} {incr k} {
	set bin($k) 0
#	puts "bin($k)"
}
#set lista {-1.99 1.95 -1.87 0.89 1.23 1.44 1.91 1.92 1.98}

for {set i $min} {$i <= $max} {incr i} {
	set inti [expr $i/$binsize]
	lappend lista $inti
}
#puts "lista = $lista"
set listb [lsort -real -increasing $lista]
#puts "listb = $listb"
for {set j $min} {$j <= $max} {incr j} {
	set intj [expr $j/$binsize]
	set bin($j) [lsearch -exact $listb $intj]
#	puts "bin($j) = $bin($j)"
}
for {set m $min} {$m < $max} {incr m} {
	puts "bin([expr $m/$binsize]) = $bin($m), bin([expr ($m+1)/$binsize]) = $bin([expr $m+1]) \
		minvalue [expr (($m/$binsize) + (($m+1)/$binsize))/2] : number = [expr $bin([expr $m+1]) - $bin($m) -1]"
}
