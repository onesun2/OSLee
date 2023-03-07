#!/usr/bin/tclsh
set num_steps [molinfo top get numframes]
set cap [atomselect top "(name CC1 to CC3) or (name C01 to C18)"]
set out [open out.dat w]

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
	$cap frame $frame
	set center [geom_center $cap]
	set x [lindex $center 0]
	set y [lindex $center 1]
	set z [lindex $center 2]
	set rr [expr sqrt($y*$y + $z*$z)]
	if {$rr <= 0.5} {
		puts $out "frame = $frame, rr = $rr"
	}
}
