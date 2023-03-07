#!/usr/bin/tclsh
package require math::statistics

set all [atomselect top "all"]
set bbb [atomselect top "segname LYZ and backbone"]
set lyz [atomselect top "segname LYZ"]
set out [open outrgyr.dat w]
set num_steps [molinfo top get numframes]
set ttt {}

for {set frame 0} {$frame < $num_steps} {incr frame} {
	$bbb frame $frame
	$bbb update
	if {$frame > [expr 0.75*$num_steps]} {
		lappend ttt [measure rgyr $bbb]
	}
	puts $out "$frame [measure rgyr $bbb]"
}
puts $out "#avg [::math::statistics::mean $ttt], stdev [::math::statistics::stdev $ttt]"
puts "#avg [::math::statistics::mean $ttt], stdev [::math::statistics::stdev $ttt]"
set ttt {}
close $out

