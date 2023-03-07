#!/usr/bin/tclsh
set n 0
set fileId1 [open plot4z1015.dat "w"]
set f1 [open plot4z1014.dat r]
set f2 [open plot4z1415.dat r]

while {[gets $f1 line1] >= 0} {
	global pos1 f1a f2a fexpa
	set pos1 [lindex $line1 0]
	set f1a [lindex $line1 1]
	set f2a [lindex $line1 2]
	set fexpa [lindex $line1 3]

	puts $fileId1 [format "%15.7f %15.9f %15.9f %15.9f" $pos1 $f1a $f2a $fexpa]
}

while {[gets $f2 line2] >= 0} {
	set pos2 [lindex $line2 0]
	set f1b [lindex $line2 1]
	set f2b [lindex $line2 2]
	set fexpb [lindex $line2 3]

	if {$n == 0} {
		set diff1 [expr $f1a - $f1b]
		set diff2 [expr $f2a - $f2b]
		set diff3 [expr $fexpa - $fexpb]
	} else {
		puts $fileId1 [format "%15.7f %15.9f %15.9f %15.9f" $pos2 [expr $f1b+$diff1] [expr $f2b+$diff2] [expr $fexpb+$diff3]]
	}

	incr n
}
close $fileId1
close $f1
close $f2
