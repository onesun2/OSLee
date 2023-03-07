#!/usr/bin/tclsh
package require Tcl 8
package require math::statistics
########################
set out [open outdist.dat w]
set num_steps [molinfo top get numframes]
set ttt {}

set lyz [atomselect top "segname LYZ"]
set c60 [atomselect top "type CPS"]

proc geom_center {selection} {
        set gc [veczero]
        foreach coord [$selection get {x y z}] {
                set gc [vecadd $gc $coord]
        }
        return [vecscale [expr 1.0/[$selection num]] $gc]
}

###################################################################
###           MAIN                                             ####
###################################################################
for {set frame 0} {$frame < $num_steps} {incr frame} {
#	puts "frame = $frame"
	$lyz frame $frame
	$c60 frame $frame
	$lyz update
	$c60 update

	set x1 [lindex [geom_center $lyz] 0]
	set y1 [lindex [geom_center $lyz] 1]
	set z1 [lindex [geom_center $lyz] 2]

	set x2 [lindex [geom_center $c60] 0]
	set y2 [lindex [geom_center $c60] 1]
	set z2 [lindex [geom_center $c60] 2]

	set prod [expr ($x1-$x2)*($x1-$x2)+($y1-$y2)*($y1-$y2)+($z1-$z2)*($z1-$z2)]
	puts $out "$frame [expr sqrt($prod)]"
}
#puts $out "pitch_av2 = [::math::statistics::mean $ttt], stdev = [::math::statistics::stdev $ttt]"
set ttt {} 
close $out
