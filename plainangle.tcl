#!/usr/bin/tclsh
package require Tcl 8
package require math::statistics
set tcl_precision 12
set pi 3.14159265358979323846
set out [open angle.dat w]
set num_steps [molinfo top get numframes]
#set num_steps 100 
set ttt [atomselect top "(same residue as ((within 4 of segname GR1) and (within 4 of segname GR2))) and (name C1)"]
set ccc {}
set data {}
set num 0

for {set frame 0} {$frame < $num_steps} {incr frame} {
	$ttt frame $frame
	$ttt update
	set c1list($frame) [$ttt get index] 
#	puts $out "c1list($frame) $c1list($frame)"
}

for {set frame 0} {$frame < $num_steps} {incr frame} {
        foreach i $c1list($frame) {
                if {[lsearch $ccc $i]<0} {
                        lappend ccc [lindex $c1list($frame) [lsearch $c1list($frame) $i]]
                }
        }
}

foreach i $ccc {
        set c1($i) [atomselect top "index $i"]
        set c2([expr $i+3]) [atomselect top "index [expr $i+3]"]
        set c3([expr $i+4]) [atomselect top "index [expr $i+4]"]
}

for {set frame 0} {$frame < $num_steps} {incr frame} {
        $ttt frame $frame
        foreach i $ccc {
                $c1($i) frame $frame
                $c2([expr $i+3]) frame $frame
                $c3([expr $i+4]) frame $frame
        }

        foreach i $ccc {
                set coorC1($i,$frame) [measure center $c1($i)]
                set coorC2([expr $i+3],$frame) [measure center $c2([expr $i+3])]
                set coorC3([expr $i+4],$frame) [measure center $c3([expr $i+4])]
#		puts $out "$frame, $i, $coorC1($i,$frame), $coorC2([expr $i+3],$frame), $coorC3([expr $i+4],$frame)"
        }
}

for {set frame 0} {$frame < $num_steps} {incr frame} {
	foreach i $c1list($frame) {
#		puts $out "$frame $i"
		set v1 [vecnorm [vecsub $coorC2([expr $i+3],$frame) $coorC1($i,$frame)]]
		set v2 [vecnorm [vecsub $coorC3([expr $i+4],$frame) $coorC1($i,$frame)]]
		set v3 [vecnorm [veccross $v1 $v2]]
		set ang [expr (180.0/$pi)*acos([vecdot {1 0 0} $v3])]
		puts $out "$ang"
		lappend data $ang
		set num [expr $num + 1]
	}
}
puts $out "#avg = [::math::statistics::mean $data], stdev = [::math::statistics::stdev $data]"
puts $out "#number = $num"
set num 0
close $out
