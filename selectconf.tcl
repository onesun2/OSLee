#!/usr/bin/tclsh
set fileId1 [open conf.dat "w"]
set f1 [open temp.dat r]

for {set number 1} {$number <= 20000} {incr number} {
	gets $f1 line1

	set frame [lindex $line1 0]
	set dist [lindex $line1 1]
	set angle [lindex $line1 2]

	if {$dist >= 0.4 && $dist <= 0.6 && $angle >= 10 && $angle <= 30} {
		puts $fileId1 [format "%10.d %10.3f %15.9f" $frame $dist $angle]
		animate write pdb c$number.pdb beg $number end $number skip 1 0
	}
}
close $fileId1
close $f1

