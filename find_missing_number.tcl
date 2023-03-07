#!/usr/bin/tclsh
set f [open [lindex $argv 0] r]
set fileId [open out.dat w]
set d(0) 0
set n 1 
while {[gets $f line] >= 0} {
	set d($n) [lindex $line 0]
	set diff [expr $d($n) - $d([expr $n-1])]
	if {$diff > 1} {
		puts $fileId [format "%4d %4d" [expr $d($n)-$diff+1] $diff]
	}
	incr n
}
