#!/usr/bin/tclsh
set filename "num.txt"
set fileId [open $filename "w"]

###################################################################
###           MAIN                                             ####
###################################################################
for {set i 0} {$i <= 10} {incr i} {
	for {set j 0} {$j <=10} {incr j} {
		set diff [expr ($i*$i + $i*$j + $j*$j)-100]
		if {[expr abs($diff)] <= 3} {
			puts $fileId "i = $i, j = $j, error = $diff, diameter = [expr (1.742*1.40*sqrt($i*$i+$i*$j+$j*$j))/3.141592]"
		}
	}
}
close $fileId
