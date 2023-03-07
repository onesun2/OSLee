#!/usr/bin/tclsh
package require math::statistics
########################
set f [open [lindex $argv 0] r]
set out [open outEntropy.dat w]
set out2 [open flucE.dat w]
set ttt {}
set sum 0.0 
set n 0
###################################################################
###           MAIN                                             ####
###################################################################
while {[gets $f line] >= 0} {
	set time [lindex $line 0]
	set ene [lindex $line 1]
	lappend ttt $ene
	set avg [::math::statistics::mean $ttt]
#	puts $out "$time $ene $avg" 
	puts $out2 "$time [expr $ene - $avg]"
	set aaa [expr exp(($ene - $avg)/0.596)]
	set sum [expr $sum + $aaa]
	set enp [expr 0.596*log($sum/($n+1))]
	puts $out "$time $enp"
	incr n
}
set sum 0.0
set n 0
close $out
close $out2
close $f

