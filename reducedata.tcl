#!/usr/bin/tclsh
set n 0
set f [open [lindex $argv 0] r]
set out [open new_data.dat w]
while {[gets $f line] >= 0} {
	if {$n%10 == 0} {
		puts $out "$line" 
	}
	incr n
}
close $f
close $out

