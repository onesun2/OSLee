#!/usr/bin/tclsh
set n 0
set f [open [lindex $argv 0] r]
set filename newplot4.plot
set fileId [open $filename "w"]
while {[gets $f line] >= 0} {
	set time [lindex $line 0]
	set f1 [lindex $line 1]
	set f2 [lindex $line 2]
	set fexp [lindex $line 3]
	if {$n%10 == 0} {
		puts $fileId [format "%10.5f %10.6f %10.6f %10.6f" $time $f1 $f2 $fexp]
	}
	incr n
}
