#!/usr/bin/tclsh
set n 0
set f [open [lindex $argv 0] r]
set filename sample.dat
set fileId [open $filename "w"]
while {[gets $f line] >= 0} {
	set time [lindex $line 0]
	set dist [lindex $line 1]
	set force [lindex $line 2]
	if {$n%10 == 0} {
		puts $fileId [format "%10.5f %10.6f %10.6f" $time $dist $force]
	}
	incr n
}
