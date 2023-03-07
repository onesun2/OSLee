#!/usr/bin/tclsh
set fileId [open vec_angle.txt "w"]
set num_steps [molinfo top get numframes]
set PI 3.1415926535897932384626

set caps [atomselect top "(name CC1 to CC6) or (name C01 to C36)"]
set upper [atomselect top "name CC1 CC2 CC3"]
set down [atomselect top "name CC4 CC5 CC6"]
set xe [atomselect top "segname XE1"]

proc geom_center {selection} {
        set gc [veczero]
        foreach coord [$selection get {x y z}] {
                set gc [vecadd $gc $coord]
        }
        return [vecscale [expr 1.0/[$selection num]] $gc]
}
########################################
####MAIN
########################################
for {set frame 0} {$frame < $num_steps} {incr frame} {
        $upper frame $frame
        $down frame $frame
	$caps frame $frame

	set c1 [geom_center $caps]
	set uc [geom_center $upper]
	set dc [geom_center $down]

	set vec1 [vecnorm [vecsub $uc $c1]]
	set vec2 [vecnorm [vecsub $dc $c1]]

	set costheta [vecdot $vec1 $vec2]
	set angle [expr (180.0/$PI)*acos($costheta)]

	puts $fileId "$angle"
}

