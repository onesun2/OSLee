#!/usr/bin/tclsh
set f [open [lindex $argv 0] r]
set n 0
while {[gets $f line] >= 0} {
	set n [expr $n+1]
	set ttt($n) $line
}

for {set i $n} {$n > 0} {incr n -1} {
	puts $ttt($n)
}

