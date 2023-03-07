#!/usr/bin/tclsh
set f1 [open [lindex $argv 0] r]
set f2 [open [lindex $argv 1] r]
set out [open out.ene w]

for {set i 0} {$i <=1000} {incr i} {
	gets $f1 line1
	set time1($i) [lindex $line1 0]
	set ene1($i) [lindex $line1 1]
#	puts $out "$time1($i)"
#	puts $out [format "%12.5f" $time1($i)]
}

for {set j 0} {$j <=1000} {incr j} {
	gets $f2 line2
	set time2($j) [lindex $line2 0]
	set ene2($j) [lindex $line2 1]
#	puts $out "$time2($j)"
}

for {set i 0} {$i <=1000} {incr i} {
	puts $out "$time1($i) $ene1($i)" 
##	puts $out [format "%12.5f %12.6f" $time($i) $ene($i)] 
}

for {set j 1} {$j <=1000} {incr j} {
	set diff [expr $ene1(1000) - $ene2(0)]
#	puts $out "diff = $diff"
#	puts $out "$time2($j) $ene2($j)" 
	puts $out "$time2($j) [expr $ene2($j)+$diff]"
#	puts $out [format "%12.5f %12.6f" $time2($j) [expr $ene2($j)-$diff]]
}
close $out

