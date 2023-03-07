#!/usr/bin/tclsh

set num_steps [molinfo top get numframes]
set m00 [atomselect top "(name CA1 CA2 CA3 CA4 CA5 CA6) and (residue  0)"]
set m01 [atomselect top "(name CA1 CA2 CA3 CA4 CA5 CA6) and (residue  1)"]

set out [open mdis.txt w]

proc geom_center {selection} {
	set gc [veczero]
	foreach coord [$selection get {x y z}] {
		set gc [vecadd $gc $coord]
	}
	return [vecscale [expr 1.0/[$selection num]] $gc]
}

for {set frame 0} {$frame < $num_steps} {incr frame} {

	$m00 frame $frame	
	$m01 frame $frame	

	set c00 [geom_center $m00]
	set c01 [geom_center $m01]

	puts $out "frame = $frame"
	puts $out "[vecdist $c00 $c01]"
}
close $out
