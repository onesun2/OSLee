#!/usr/bin/tclsh
set n 0
set fileId1 [open PMFcra1213_1314.dat "w"]
set f1 [open cra_z1213PMF.dat r]
set f2 [open cra_z1314PMF.dat r]

while {[gets $f1 line1] >= 0} {
	global pos1 f2av1 fexpav1
	set pos1 [lindex $line1 0]
	set f2av1 [lindex $line1 1]
	set fexpav1 [lindex $line1 2]
	set stdev1a [lindex $line1 3]
	set stdev2a [lindex $line1 4]

	if {($stdev1a == 0) && ($stdev2a == 0)} {	
		puts $fileId1 [format "%15.7f %15.9f %15.9f" $pos1 $f2av1 $fexpav1]
	} else {
		puts $fileId1 [format "%15.7f %15.9f %15.9f %15.9f %15.9f" $pos1 $f2av1 $fexpav1 $stdev1a $stdev2a]
	}
}

while {[gets $f2 line2] >= 0} {
	set pos2 [lindex $line2 0]
	set f2av2 [lindex $line2 1]
	set fexpav2 [lindex $line2 2]
	set stdev1b [lindex $line2 3]
	set stdev2b [lindex $line2 4]

	if {$n == 0} {
		set diff1 [expr $f2av1 - $f2av2]
		set diff2 [expr $fexpav1 - $fexpav2]
	} else {
		if {($stdev1b == 0) && ($stdev2b == 0)} {	
			puts $fileId1 [format "%15.7f %15.9f %15.9f" $pos2 [expr $f2av2+$diff1] [expr $fexpav2+$diff2]]
		} else {
			puts $fileId1 [format "%15.7f %15.9f %15.9f %15.9f %15.9f" $pos2 [expr $f2av2+$diff1] [expr $fexpav2+$diff2] $stdev1b $stdev2b]
		}
	}

	incr n
}
close $fileId1
close $f1
close $f2
