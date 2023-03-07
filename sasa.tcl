#!/usr/bin/tclsh
package require math::statistics

set all [atomselect top "all"]
set bbb [atomselect top "segname LYZ and backbone"]
#set lyz [atomselect top "segname LYZ"]
set lyz [atomselect top "protein"]
set out [open outsasa.dat w]
set num_steps [molinfo top get numframes]
set twothird [expr 0.75*$num_steps]
set ttt {}

for {set frame 0} {$frame < $num_steps} {incr frame} {
	$lyz frame $frame
	$lyz update
	if {$frame > $twothird} {
		lappend ttt [measure sasa 1.4 $lyz]
	}
	puts $out "$frame [measure sasa 1.4 $lyz]"
}
puts $out "#avg [::math::statistics::mean $ttt], stdev [::math::statistics::stdev $ttt]"
puts "#avg [::math::statistics::mean $ttt], stdev [::math::statistics::stdev $ttt]"
set ttt {}
close $out

