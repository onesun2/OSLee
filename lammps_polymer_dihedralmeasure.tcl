#!/usr/bin/tclsh
package require Tcl 8
package require math::statistics
set ttt {}
set num_steps [molinfo top get numframes]
set alphadata {}
set out [open alphatest.dat w]

#for {set i 0} {$i <= 15048} {incr i 152} {
for {set i 0} {$i <= 15048} {incr i 152} {
	for {set j $i} {$j <= [expr $i+141]} {incr j 3} { 
	lappend alphadata $j
#	lappend alphadata Cindex($i,$j) 
#        puts  $out $j
	}
}

foreach i $alphadata {
	set a($i) [atomselect top "index $i"]
}

proc signed_angle { a b c } {
  set amag [veclength $a]
  set bmag [veclength $b]
  set dotprod [vecdot $a $b]

  set crossp [veccross $a $b]
  set sign [vecdot $crossp $c]
  if { $sign < 0 } {
    set sign -1
  } else {
    set sign 1
  }
  set temp [expr $dotprod / ($amag * $bmag)]
  if { $temp > 1 } {
	set temp 1
  } elseif { $temp < -1 } {
	set temp -1
  }
#  return [expr $sign * 57.2958 * acos($dotprod / ($amag * $bmag))]
  return [expr $sign * 57.2958 * acos($temp)]
}

proc dihedral { a1 a2 a3 a4 } {
  if {[llength $a1] != 3 || [llength $a2] != 3 || [llength $a3] != 3 || [llength $a4] != 3} {
    return 0
  }

  set r1 [vecsub $a1 $a2]
  set r2 [vecsub $a3 $a2]
  set r3 [vecscale $r2 -1]
  set r4 [vecsub $a4 $a3]

  set n1 [veccross $r1 $r2]
  set n2 [veccross $r3 $r4]

  return [signed_angle $n1 $n2 $r2]
}

proc geom_center {selection} {
	set gc [veczero]
	foreach coord [$selection get {x y z}] {
		set gc [vecadd $gc $coord]
	}
	return [vecscale [expr 1.0/[$selection num]] $gc]
}
####################
## Main ############
####################
#for {set frame 0} {$frame < $num_steps} {incr frame} {
#
#	foreach i $alphadata {
#		$a($i) frame $frame
#	}
#
	for {set i 0} {$i <= 15048} {incr i 152} {
       		for {set j $i} {$j <= [expr $i+132]} {incr j 3} {
			set alpha10 [dihedral [geom_center $a($j)] [geom_center $a([expr $j+3])] \
                 	[geom_center $a([expr $j+6])] [geom_center $a([expr $j+9])]]
               		puts $out $alpha10
#                	puts  $alpha10
                	lappend ttt $alpha10
        	}
	}
#} ;# end of main

puts $out "ave = [::math::statistics::mean $ttt], stdev = [::math::statistics::stdev $ttt]"
puts "ave = [::math::statistics::mean $ttt], stdev = [::math::statistics::stdev $ttt]"
set ttt {}
close $out
