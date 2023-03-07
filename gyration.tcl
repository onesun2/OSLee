#!/usr/bin/tclsh
set sn 2
set fn 2
set num_steps [molinfo top get numframes]
set sum 0.0
for {set n $sn} {$n <= $fn} {incr n} {
	for {set i 2} {$i <= 11} {incr i} {
		set p($n,$i) [atomselect top "(segname DN$n) and (name P) and (resid $i)"]
	}
}
set center [atomselect top "index 1465"]

set fileId1 [open rgyr2.dat w]

proc geom_center {selection} {
	set gc [veczero]
	foreach coord [$selection get {x y z}] {
		set gc [vecadd $gc $coord]
	}
	return [vecscale [expr 1.0/[$selection num]] $gc]
}

for {set frame 0} {$frame < $num_steps} {incr frame} {
	$center frame $frame
	for {set n $sn} {$n <= $fn} {incr n} {
		for {set i 2} {$i <= 11} {incr i} {
			$p($n,$i) frame $frame
		}
	}

	for {set n $sn} {$n <= $fn} {incr n} {
		for {set i 2} {$i <= 11} {incr i} {
			set pc($n,$i) [geom_center $p($n,$i)]	
		}
	}
	set gc [geom_center $center]

	for {set n $sn} {$n <= $fn} {incr n} {
		for {set i 2} {$i <= 11} {incr i} {
#			puts $fileId1 "$frame, DN$n, P$i, dist = [vecdist $gc $pc($n,$i)]"	
			set dist1 [vecdist $gc $pc($n,$i)]
			set dd [expr $dist1*$dist1]
			set sum [expr $sum + $dd]
#			puts "sum = $sum"
		}
	}
}
puts $fileId1 "Gr^2 = [expr (($sum/1000)/11)]"
puts $fileId1 "Gr = [expr sqrt((($sum/1000)/11))]"
set sum 0.0
close $fileId1
