#!/usr/bin/tclsh
set vz {0 0 1}
set n1 [atomselect top "name N1"]
set o4 [atomselect top "name O4"]
set v1 [$n1 get {x y z}]
set v2 [$o4 get {x y z}]
set ttt [vecnorm [vecsub [lindex $v2 0] [lindex $v1 0]]]
set angle [expr (180/3.141592)*acos([vecdot $ttt $vz])]
puts "angle = $angle"
