#!/usr/bin/tclsh
package require La
namespace import La::*

set v1 {1 0 0}
set v2 {1 1 0}

set vn1 [vecnorm $v1]
set vn2 [vecnorm $v2]
set angle [expr acos([vecdot $vn1 $vn2])]
puts $angle

