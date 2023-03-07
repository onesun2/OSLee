#!/usr/bin/tclsh
set n 0
set f [open [lindex $argv 0] r]
set out [open out.dat w]
while {[gets $f line] >= 0} {
	set time [lindex $line 0]
	set ave [lindex $line 4]
	set stdev [lindex $line 5]
	if {$n%10 == 0} {
		puts $fileId [format "%10.5f %10.6f %10.6f" $time $ave $stdev]
	} else {
		puts $fileId [format "%10.5f %10.6f" $time $ave]
	}
	incr n
}
