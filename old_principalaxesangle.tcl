#######################################################
#Script for measuring angle between the principal axis of given set (ttt) and x-, y-, and z-axis
#######################################################
#One-Sun Lee, Nov 2016
#QEERI, HBKU, Qatar
#Most of the script is adapted from orient.tcl
#You need La.tcl and tttttt.tcl for submitting this script
#vector a3 is the longest principal axes of selected set of atoms
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
set out [open data.dat w]
set pi 3.1415926535897931

for {set frame 0} {$frame < $num_steps} {incr frame} {
	$all frame $frame
	$ttt frame $frame
	set i [cusp $ttt]

	if {$frame == 0} {
		set a3prev $a3
		set xangle [expr acos([vecdot $a3 $xxx])*180/$pi]
#		puts $out "$a3"
	} else {
		set vpvc [vecdot $a3prev $a3]
#		puts $out "$frame $vpvc"
		if {$vpvc < 0.0} {
			set nega3 [vecscale -1 $a3]
#			puts $out "$frame [vecdot $a3prev $nega3]"
			set a3prev $nega3

			set xangle [expr acos([vecdot $nega3 $xxx])*180/$pi]
			set yangle [expr acos([vecdot $nega3 $yyy])*180/$pi]
			set zangle [expr acos([vecdot $nega3 $zzz])*180/$pi]
		} else {
			set a3prev $a3
			set xangle [expr acos([vecdot $a3 $xxx])*180/$pi]
			set yangle [expr acos([vecdot $a3 $yyy])*180/$pi]
			set zangle [expr acos([vecdot $a3 $zzz])*180/$pi]
		}
	}
#	puts "frame $frame, x $xangle, y $yangle, z $zangle"
#	puts $out "$frame $xangle"
	puts $out "$xangle"
}
close $out

