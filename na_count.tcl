#!/usr/bin/tclsh
set filename 20na_dist.dat 
set fileId [open $filename "w"]
set num_steps [molinfo top get numframes]
set aaa [atomselect top "segname SSD"]
set r 20.0

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
        $aaa frame $frame

        set cm [geom_center $aaa]

	set x1 [lindex $cm 0]
	set y1 [lindex $cm 1]
	set z1 [lindex $cm 2]

	set ttt [atomselect top "(name SOD) and ((x-$x1)*(x-$x1)+(y-$y1)*(y-$y1)+(z-$z1)*(z-$z1) < $r*$r)"]
	$ttt frame $frame
	$ttt update

	set nna [$ttt num]
#	puts $fileId "x=$x1; y=$y1; z=$z1; $frame; $nna"
	puts $fileId "$frame; $nna"
#	unset ttt
}
close $fileId
