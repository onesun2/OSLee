#!/usr/bin/tclsh

set num_steps [molinfo top get numframes]
for {set dn 1} {$dn <= 4} {incr dn} {
	for {set res 2} {$res <= 11} {incr res} {
		set dnr($dn,$res) [atomselect top "(segname DN$dn) and (resid $res) and (name N9 C8 N7 C5 C4 C6 N1 C2 N3)"] 
	}
}

set fileId1 [open mdis.txt w]
set fileId2 [open disall.txt w]

proc geom_center {selection} {
	set gc [veczero]
	foreach coord [$selection get {x y z}] {
		set gc [vecadd $gc $coord]
	}
	return [vecscale [expr 1.0/[$selection num]] $gc]
}

for {set frame 0} {$frame < $num_steps} {incr frame} {

	for {set dn 1} {$dn <= 4} {incr dn} {
		for {set res 2} {$res <= 11} {incr res} {
			$dnr($dn,$res) frame $frame	
		}
	}

	for {set dn 1} {$dn <= 4} {incr dn} {
		for {set res 2} {$res <= 11} {incr res} {
			set c($dn,$res) [geom_center $dnr($dn,$res)]
		}
	}

	for {set dn 1} {$dn <= 4} {incr dn} {
		for {set res 2} {$res <= 10} {incr res} {
#			puts $fileId1 "$dn $res	[vecdist $c($dn,$res) $c($dn,[expr $res+1])]"
#			puts $fileId1 [format "%3d %3d %12.4f  " $dn $res [vecdist $c($dn,$res) $c($dn,[expr $res+1])]] nonewline
			puts $fileId1 [format "%12.4f  " [vecdist $c($dn,$res) $c($dn,[expr $res+1])]] nonewline
			puts $fileId2 [format "%12.4f  " [vecdist $c($dn,$res) $c($dn,[expr $res+1])]] 
		}
	}
	puts $fileId1 ""
}
close $fileId1
close $fileId2
