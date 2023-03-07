package require math::statistics
set out [open log.dat w]
set out2 [open area_t.dat w]
set ttt {}
set tt2 {}
set listfar {}
set timeaveNear {}
set timeaveFar {}
set near [atomselect top "name P and (resid 1 to 70) and (within 10 of type TIO)"]
set num_steps [molinfo top get numframes]

puts $out2 "\# frame	area(near)	area(far)"
puts $out2 "\@ s0 legend \"near\"" 
puts $out2 "\@ s1 legend \"far\"" 

for {set frame 0} {$frame < $num_steps} {incr frame} {
	set frame1 [expr $frame+1]
	$near frame $frame
	$near update

	for {set i 1} {$i <= 70} {incr i} {
		set array($i) 0.0
	}
	set f1 [open ./output/output.frame$frame1.20x20.top_areas.dat r]
	
	while {[gets $f1 line] >= 0} {
		set resid [lindex $line 0]
		set area [lindex $line 2]
		set array($resid) $area
#		puts $out "array($resid) = $array($resid)"
	}
	close $f1

	puts $out "frame $frame"
	set list_resid [$near get resid]
	puts $out "listnear [$near get resid]"
	puts $out "number of near [$near num]"

	foreach i $list_resid {
#		puts $out "array($i) $array($i)"
		lappend ttt $array($i)
	}
	puts $out "ave(near) = [::math::statistics::mean $ttt], stdev = [::math::statistics::stdev $ttt]"

	lappend timeaveNear [::math::statistics::mean $ttt] ;# time average of area per lipid Near MXene
	for {set j 1} {$j <= 70} {incr j} {
		lappend listfar $j
	}

	foreach i $list_resid {
		set listfar [lremove $listfar $i]
	}
	puts $out "listfar $listfar"
	puts $out "number of far [llength $listfar]"
	
	foreach i $listfar {
		lappend tt2 $array($i)
	}	
	puts $out "ave(far) = [::math::statistics::mean $tt2], stdev = [::math::statistics::stdev $tt2]"
	puts $out " "
	puts $out2 "$frame [::math::statistics::mean $ttt] [::math::statistics::mean $tt2]"
	lappend timeaveFar [::math::statistics::mean $tt2] ;# time average of area per lipid Far from MXene

	set tt2 {}
	set ttt {}
	set listfar {}
}
puts $out2 "\# Area per lipid time ave(Near) [::math::statistics::mean $timeaveNear]"
puts $out2 "\# Area per lipid time ave(Far) [::math::statistics::mean $timeaveFar]"
puts $out2 [format "\@ title \"time average of the area per lipid (Aungstrom^2)\" "] 
puts $out2 "\@ title size 1.5"
puts $out2 [format "\@ subtitle \"near=%6.2f +/- %6.2f, far=%6.2f +/- %6.2f\" " \
 [::math::statistics::mean $timeaveNear] [::math::statistics::stdev $timeaveNear] \
 [::math::statistics::mean $timeaveFar] [::math::statistics::stdev $timeaveFar] ]
puts $out2 "\@ subtitle size 1.5"

close $out
close $out2

