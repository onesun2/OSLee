#!/usr/bin/tclsh
package require Tcl 8
package require math::statistics
#starting/ending monomer number
set sm 3
set em 7
########################
set filename "d10n10base_distribution${sm}to${em}.txt"
set fileId [open $filename "w"]
set num_steps [molinfo top get numframes]
set vz {0 0 1}
set data {}
set pi 3.1415926535897932384626433832795

for {set i $sm} {$i <= $em} {incr i} {
                set N1($i) [atomselect top "(name N1) and (resid $i)"]
                set O4($i) [atomselect top "(name O4) and (resid $i)"]
}

###################################################################
###           MAIN                                             ####
###################################################################
for {set frame 0} {$frame < $num_steps} {incr frame} {
#	puts "frame = $frame"
	for {set i $sm} {$i <= $em} {incr i 2} {
                $N1($i) frame $frame
                $O4($i) frame $frame
        }

	for {set i $sm} {$i <= $em} {incr i 2} {
		set v1 [$N1($i) get {x y z}]
		set v2 [$O4($i) get {x y z}]
		set vr($i) [vecnorm [vecsub [lindex $v2 0] [lindex $v1 0]]]
		set angle [expr (180/$pi)*acos([vecdot $vr($i) $vz])]
		puts $fileId [format "frame = %4d, angle(%1d) =   %6.2f" $frame $i $angle]
#		puts "frame = $frame, angle($i) = $angle"
		lappend data $angle
        }
}
puts $fileId "angle_ave${sm}_${em} = [::math::statistics::mean $data], stdev = [::math::statistics::stdev $data]"
puts "angle_ave${sm}_${em} = [::math::statistics::mean $data], stdev = [::math::statistics::stdev $data]"
set data {}
close $fileId
