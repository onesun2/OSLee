#!/usr/bin/tclsh
set x 6.0
set y 0.0
set angle 60.0

proc rotation {x y angle} {
	set position {}
	set PI 3.141592
	set theta [expr ($angle/180.0)*$PI]
	set new_x [expr $x*cos($theta) - $y*sin($theta)]
	lappend position $new_x
	set new_y [expr $x*sin($theta) + $y*cos($theta)]
	lappend position $new_y
	return $position
} 

for {set i 1} {$i <=17} {incr i} {
	set new_position [rotation $x $y $angle]
	set x [lindex $new_position 0]
	set y [lindex $new_position 1]
	puts "$new_position"
}
