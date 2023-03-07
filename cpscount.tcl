#!/usr/bin/tclsh
package require Tcl 8
package require math::statistics
########################
set out [open numcps.dat w]
set num_steps [molinfo top get numframes]
set lyz [atomselect top "segname LYZ"]
set c60 [atomselect top "type CPS"]
set cps [atomselect top "type CPS and (within 7.5 of name CA)"]
set ttt {}
###################################################################
###           MAIN                                             ####
###################################################################
for {set frame 0} {$frame < $num_steps} {incr frame} {
	$cps frame $frame
	$cps update
	lappend ttt [$cps num]
	puts $out "$frame [$cps num]"
}
puts $out "avg = [::math::statistics::mean $ttt], stdev = [::math::statistics::stdev $ttt]"
puts  "avg = [::math::statistics::mean $ttt], stdev = [::math::statistics::stdev $ttt]"
set ttt {} 
close $out

