#!/usr/bin/tclsh
package require Tcl 8
package require math::statistics
set out [open dat.dat w]
set num_steps [molinfo top get numframes]
set ttt {}

for {set res 0} {$res <= 728} {incr res} {
	set r($res) [atomselect top "residue $res"]
}
for {set frame 0} {$frame < $num_steps} {incr frame} {
	for {set res 0} {$res <= 728} {incr res} {
		$r($res) frame $frame
		$r($res) update
	}

	for {set res 0} {$res <= 728} {incr res} {
		puts $out "$frame $res [measure rgyr $r($res)]"
		lappend ttt [measure rgyr $r($res)]
	}
}
puts $out "average = [::math::statistics::mean $ttt], stdev = [::math::statistics::stdev $ttt]"
close $out
