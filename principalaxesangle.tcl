#######################################################
#Script for measuring angle between the principal axis of given set (ttt) and x-, y-, and z-axis
#######################################################
#One-Sun Lee, Nov 2016
#QEERI, HBKU, Qatar
#Most of the script is adapted from orient.tcl
#You need La.tcl and tttttt.tcl for submitting this script
#######################################################
package require La
source tttttt.tcl
namespace import Tttttt::orient
set num_steps [molinfo top get numframes]
set all [atomselect top "all"]
set ttt [atomselect top "(segname P1) and (name CA) and (resid 2 to 7)"]
set i [cusp $ttt]
set xxx {1 0 0}
set yyy {0 1 0}
set zzz {0 0 1}
set out [open xydata.dat w]
set pi 3.1415926535897931
################
#three unit vectors on graphene surface
################
set i1252 [atomselect top "index 1252"]
set i1258 [atomselect top "index 1258"]
set i1254 [atomselect top "index 1254"]
set dot1 {}
set dot2 {}
set dot3 {}
#lappend dot1 [$i1252 get x] [$i1252 get y] [$i1252 get z] 
#lappend dot2 [$i1258 get x] [$i1258 get y] [$i1258 get z] 
#lappend dot3 [$i1254 get x] [$i1254 get y] [$i1254 get z] 
lappend dot1 [$i1252 get x] [$i1252 get y] 0 
lappend dot2 [$i1258 get x] [$i1258 get y] 0 
lappend dot3 [$i1254 get x] [$i1254 get y] 0 
set v1 [vecnorm [vecsub $dot1 $dot2]] ;#### dot3----dot2
set v2 [vecnorm [vecsub $dot2 $dot3]] ;####     \  /
set v3 [vecnorm [vecsub $dot3 $dot1]] ;####      dot1
#################
for {set frame 0} {$frame < $num_steps} {incr frame} {
	$all frame $frame
	$ttt frame $frame
	set i [cusp $ttt]

	if {$frame == 0} {
		set a3prev $a3
#		set xangle [expr acos([vecdot $a3 $xxx])*180/$pi]
		set xangle [expr acos([vecdot $a3 $v1])*180/$pi]
#		puts $out "$a3"
	} else {
		set vpvc [vecdot $a3prev $a3]
#		puts $out "$frame $vpvc"
		if {$vpvc < 0.0} {
			set nega3 [vecscale -1 $a3]
			set tempa3 {}
			lappend tempa3 [lindex $nega3 0]
			lappend tempa3 [lindex $nega3 1]
			lappend tempa3 0.0
			set tempa3norm [vecnorm $tempa3]
#			puts $out "$frame [vecdot $a3prev $nega3]"
			set a3prev $nega3

#			set xangle [expr acos([vecdot $tempa3norm $xxx])*180/$pi]
			set xangle [expr acos([vecdot $tempa3norm $v1])*180/$pi]
		} else {
			set a3prev $a3
			set tempa3 {}
                        lappend tempa3 [lindex $a3 0]
                        lappend tempa3 [lindex $a3 1]
                        lappend tempa3 0.0
                        set tempa3norm [vecnorm $tempa3]
#			set xangle [expr acos([vecdot $tempa3norm $xxx])*180/$pi]
			set xangle [expr acos([vecdot $tempa3norm $v1])*180/$pi]
		}
	}
#	puts "frame $frame, x $xangle, y $yangle, z $zangle"
#	puts $out "$frame $xangle"
	puts $out "$frame $xangle"
}
close $out

