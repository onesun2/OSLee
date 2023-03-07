#!/usr/bin/tclsh
#build gold particle
set file [open "test.pdb" w]
set x 0.0
set y 0.0
set z 0.0
	puts $file "         1         2         3         4         5         6         7         8         9          "
	puts $file "1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
for {set k 0} {$k <= 20} {incr k} {
	if {$k%3 == 0} {
		set x0 0.0
		set y0 0.0
	}
	if {$k%3 == 1} {
		set x0 1.5
		set y0 0.866
	}
	if {$k%3 == 2} {
		set x0 3.0
		set y0 1.732
	}
	set z [expr 2.449*$k]
	for {set j 0} {$j <= 20} {incr j} {
		if {$j%2 == 0} {
			set x [expr $x0 + 0.0]
		}
		if {$j%2 != 0} {
			set x [expr $x0 + 1.5] 
		}
		set y [expr 2.598*$j + $y0]
	
		for {set i 0} {$i <= 20} {incr i} {
			set x [expr $x+3.0]
			puts $file [format "ATOM  %5d  AU0 GLD  %4d    %8.3f%8.3f%8.3f" $i $i $x $y $z]
		}
	}
}
puts $file "END"
close $file

