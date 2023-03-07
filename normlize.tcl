#!/usr/bin/tclsh
set f [open [lindex $argv 0] r]
set canon 65.0
set out [open ttt.out w]
set sum 0.0
while {[gets $f line] >= 0} {
	set ele [lindex $line 1]
	set sum [expr $sum + $ele]
}
puts "$sum"
seek $f 0
while {[gets $f line] >= 0} {
	set bin [lindex $line 0]
	set ele [lindex $line 1]
#	set ddd [if {$bin == $canon} {return 0.0} else {return 1.0}]
#	puts $out [format "%10.3f %18.5f %5.2f" $bin [expr $ele/$sum] $ddd]
	puts $out [format "%10.3f %18.5f" $bin [expr $ele/$sum]]
}
set sum 0.0
close $out
