#!/usr/bin/tclsh
for {set num 0} {$num <= 1000} {incr num 10} {

	set filename1 "gna1000kmm$num.res"
        set fileId1 [open $filename1 "r"]

	while {[gets $fileId1 line] >= 0} {
		if {[lindex $line 0] == "ENERGY:" && [lindex $line 1] == 100000} {
			set filename2 "test.res"
			set fileId2 [open $filename2 "a"]
			puts $fileId2 "[lindex $line 0] [lindex $line 11] $filename1"
			close $fileId2
		}
	}
	close $fileId1
}	
