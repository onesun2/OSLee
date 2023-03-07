#!/usr/bin/tclsh
set file [open "test.pdb" w]
set x 0.0
set y 0.0
set z 0.0
	puts $file "         1         2         3         4         5         6         7         8         9          "
	puts $file "1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"

	for {set j 0} {$j <= 10} {incr j} {
		if {$j%2 == 0} {
			set x 0.0 
		}
		if {$j%2 != 0} {
			set x 1.5 
		}
		set y [expr 2.598*$j]
	
		for {set i 0} {$i <= 10} {incr i} {
			set x [expr $x+3.0]
			puts $file [format "ATOM  %5d  AU0 GLD  %4d    %8.3f%8.3f%8.3f" $i $i $x $y $z]
		}
	}
puts $file "END"
close $file

