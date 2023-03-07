#!/usr/bin/tclsh
package require Tcl 8
package require math::statistics
set fileId [open aaa.dat "w"]
set data {}
set num_steps [molinfo top get numframes]

for {set i 0} {$i <= 18} {incr i} {
	set a($i,4) [atomselect top "(residue $i) and (name C04)"]
	set a($i,8) [atomselect top "(residue $i) and (name C08)"]
	set a($i,7) [atomselect top "(residue [expr $i+1]) and (name C07)"]
}

for {set i 0} {$i <= 18} {incr i} {
	set b($i,8) [atomselect top "(residue $i) and (name C08)"]
	set b($i,7) [atomselect top "(residue [expr $i+1]) and (name C07)"]
	set b($i,1) [atomselect top "(residue [expr $i+1]) and (name C01)"]
}

proc angle {a b c} {
	set v1 [vecsub $a $b]
	set v2 [vecsub $c $b]

	set ddd [vecdot $v1 $v2]
	set len [expr [veclength $v1]*[veclength $v2]]

	return [expr 57.2958*acos($ddd/$len)]
}

for {set frame 0} {$frame < $num_steps} {incr frame} {
	for {set i 0} {$i <= 18} {incr i} {
		$a($i,4) frame $frame	
		$a($i,8) frame $frame	
		$a($i,7) frame $frame
	}
	for {set i 0} {$i <= 18} {incr i} {
		$b($i,8) frame $frame	
		$b($i,7) frame $frame
		$b($i,1) frame $frame
	}

	for {set j 0} {$j <= 18} {incr j} {
		set ac($j,4) [measure center $a($j,4)]
		set ac($j,8) [measure center $a($j,8)]
		set ac($j,7) [measure center $a($j,7)]
	}
	for {set j 0} {$j <= 18} {incr j} {
		set bc($j,8) [measure center $b($j,8)]
		set bc($j,7) [measure center $b($j,7)]
		set bc($j,1) [measure center $b($j,1)]
	}

#	puts $fileId "frame = $frame"
#	puts $fileId "[angle $a01c $a02c $a03c]"
#	puts $fileId "number of data = [llength $data]"

	for {set k 0} {$k <= 18} {incr k} {
		lappend data [angle $ac($k,4) $ac($k,8) $ac($k,7)]
	}
	for {set k 0} {$k <= 18} {incr k} {
		lappend data [angle $bc($k,8) $bc($k,7) $bc($k,1)]
	}

}
puts "ave = [::math::statistics::mean $data], stdev = [::math::statistics::stdev $data]"
puts $fileId "ave = [::math::statistics::mean $data], stdev = [::math::statistics::stdev $data]"
puts $fileId "number of data = [llength $data]"
set data {}
close $fileId
