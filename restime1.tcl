#!/usr/bin/tclsh

set f [open [lindex $argv 0] r]
set n 0
set rmin 0.3
set rmax 0.6
set amin 170.0
set amax 180.0
set out [open residence${rmin}r${rmax}_${amin}a${amax}.out w]

while {[gets $f line] >= 0} {
	set pos [lindex $line 0]
	set ang [lindex $line 1]
	if {$pos > $rmin && $pos <= $rmax && $ang > $amin && $ang <=$amax} {
#		puts "time = $n, pos = $pos, angle = $ang, auto = 1"
		puts $out "1"
	} else {
#		puts "time = $n, pos = $pos, angle = $ang, auto = 0"
		puts $out "0"
	}
	incr n
}
