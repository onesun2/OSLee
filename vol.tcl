package require math::statistics
set num_steps [molinfo top get numframes]
set out [open calcvol.dat w]
set all [atomselect top "all"]
set ttt {}

for {set frame 0} {$frame < $num_steps} {incr frame} {

	set vol [expr [lindex [pbc get -first $frame -last $frame] 0 0]*[lindex [pbc get -first $frame -last $frame] 0 1]*[lindex [pbc get -first $frame -last $frame] 0 2]]

	if {$frame == 0} {
#		set initvol $vol	
		set initvol [expr 53.2*53.8*28]
	}	

	if {$frame > 500} {
		lappend ttt $vol
	}
	puts $out "$frame [expr $vol/$initvol]"
}
puts "initvol = $initvol"
puts "avg = [::math::statistics::mean $ttt], stdev = [::math::statistics::stdev $ttt]"
set avg  [::math::statistics::mean $ttt]
set std  [::math::statistics::stdev $ttt]
set wat [atomselect top "name OH2"]
set den2 [expr [$wat num]/$avg]
set temp [expr [$wat num]/[expr $std+$avg]]
set diff [expr $den2*$initvol - $temp*$initvol]

puts "number of water [$wat num]"
puts "expected number of water = [expr $den2*$initvol] +/- $diff"
close $out

