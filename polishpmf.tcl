#!/usr/bin/tclsh
set n 0
set fileId1 [open cra_z1016PMF_polish.dat "w"]
set f1 [open cra_z1016PMF.dat r]

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

close $fileId1
close $f1
