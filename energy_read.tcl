#!/usr/bin/tclsh
set out [open Eall.dat w]
set t 0
for {set i 90} {$i < 130} {incr i} {
	set f [open r$i r]
	while {[gets $f line] >= 0} {
		set vdwe($i,$t) [lindex $line 2]
		incr t
	}
	set t 0
	close $f
}

for {set t 0} {$t < 200} {incr t} {
	puts $out "$t " nonewline
	for {set i 90} {$i < 130} {incr i} {
		puts $out "$vdwe($i,$t) " nonewline
	}	
	puts $out ""
}
close $out

