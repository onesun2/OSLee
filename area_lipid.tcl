#!/usr/bin/tclsh
package require Tcl 8
package require math::statistics
set out [open result_area.dat w]
set num_steps [molinfo top get numframes]
set all [atomselect top "all"]
set ttt {}
###################################################################
###           MAIN                                             ####
###################################################################
for {set frame 0} {$frame < $num_steps} {incr frame} {
	animate goto $frame
	set xx [lindex [pbc get] 0 0]
	set yy [lindex [pbc get] 0 1]
	set area [expr $xx*$yy/70.0]
	puts $out "$frame $area"
	lappend ttt $area
}
puts $out "\# ave = [::math::statistics::mean $ttt], stdev = [::math::statistics::stdev $ttt]"
puts "ave = [::math::statistics::mean $ttt], stdev = [::math::statistics::stdev $ttt]"
set ttt {} 
close $out

