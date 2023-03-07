package require math::statistics
set all [atomselect top "all"]
set mo1 [atomselect top "type MO and z>0"]
set mo2 [atomselect top "type MO and z<0"]
set out [open moz.dat w]
set ttt1 {}
set ttt2 {}
set num_steps [molinfo top get numframes]
for {set frame 0} {$frame < $num_steps} {incr frame} {
	$mo1 frame $frame
	$mo2 frame $frame
	lappend ttt1 [lindex [measure center $mo1] 2]
	lappend ttt2 [lindex [measure center $mo2] 2]
	puts $out "$frame [lindex [measure center $mo1] 2] [lindex [measure center $mo2] 2]"
}
puts "mo1av = [::math::statistics::mean $ttt1], stdev = [::math::statistics::stdev $ttt1]"
puts "mo2av = [::math::statistics::mean $ttt2], stdev = [::math::statistics::stdev $ttt2]"
set mo1av [::math::statistics::mean $ttt1]
set mo2av [::math::statistics::mean $ttt2]
set st1 [::math::statistics::stdev $ttt1]
set st2 [::math::statistics::stdev $ttt2]
puts "[expr $mo1av - $mo2av] [expr sqrt($st1*$st1+$st2*$st2)]"
set ttt1 {}
set ttt2 {}
close $out

