#!/usr/bin/tclsh
set pi 3.141592265358979323846264338327950288419716939937510
set RT 0.60
set integ 0.0
set sum 0.0
set ds 0.0002
set f [open [lindex $argv 0] r]
set filename K_bind.dat
set fileId [open $filename "w"]
while {[gets $f line] >= 0} {
	set pos [lindex $line 0]
	set fexp [lindex $line 1]
	set integ [expr ($pos+ $ds/2)*($pos+ $ds/2)*exp(-$fexp/$RT)]
	set sum [expr $sum + $integ]

	puts $fileId [format "%10.5f %10.6f %10.6f" $pos $integ $sum]
}
puts $fileId "K_bind = [expr 4*$pi*6.02*0.0001*$sum*$ds]"
puts "K_bind = [expr 4*$pi*6.02*0.0001*$sum*$ds]"
