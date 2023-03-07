#!/usr/bin/tclsh
#package require Tcl 8
#package require math::statistics

set f [open [lindex $argv 0] r]
set n 0 ;# number of data
set x {} ;# raw data
set yy {} ;# raw data - mean
set norm 0.0
set sum 0.0
set mulsum 0.0
while {[gets $f line] >= 0} {
	lappend x $line
	incr n
}
puts "n = $n"

for {set i 0} {$i <= [expr $n-1]} {incr i} {
	set t [lindex $x $i]
	set sum [expr $sum + $t]
}
set mean [expr $sum/$n]
puts "mean = $mean"

foreach k $x {
	set tt [expr $k - $mean]
	lappend yy $tt
}
foreach j $yy {
	set norm [expr $norm + $j*$j]
}
puts "norm = $norm"

for {set h 0} {$h <= [expr $n-1]} {incr h} {
	for {set l 0} {$l <= [expr (($n-1) - $h)]} {incr l} {
		set t [expr $h + $l]
		set a [lindex $yy $t]
		set b [lindex $yy $l]
		set mul [expr $a * $b]
		set mulsum [expr $mulsum + $mul]
	}
	set ff [expr $mulsum/$norm]
	puts "acf = $ff"
	set mulsum 0
}
