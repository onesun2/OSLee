#!/usr/bin/tclsh

#####################################
### Definition of variables
#####################################
set num_steps [molinfo top get numframes]
set initr 1
set finalr 144
set out1 [open list_interH.out w]
set out2 [open list_intraH.out w]
set out3 [open numtotalH.out w]
set out4 [open interHnum.out w]
set out5 [open intraHnum.out w]
set bond 3.0
set angle 20.0
set totH 0.0
set totintraH 0.0

for {set i $initr} {$i <= $finalr} {incr i} {
	set s($i) [atomselect top "segname S$i"]	
}

for {set i $initr} {$i <= $finalr} {incr i} {
	for {set j $initr} {$j <= $finalr} {incr j} {
		set sum($i) 0.0
	}
}

for {set i $initr} {$i <= $finalr} {incr i} {
	for {set j $initr} {$j <= $finalr} {incr j} {
		set numH($i,$j) 0.0	;# number of H-bond between residues s(i) and s(j)
	}
}

#####################################
### End of definition of variables
#####################################


############################################################
### Main
############################################################
for {set frame 0} {$frame < $num_steps} {incr frame} {

	for {set i $initr} {$i <= $finalr} {incr i} {
		$s($i) frame $frame 
	}
#####################################
###Inter-molecular hydrogen bonds
#####################################
	for {set i $initr} {$i <= $finalr} {incr i} {
		for {set j $initr} {$j <= $finalr} {incr j} {
			if {$i != $j} {
				set numH($i,$j) [llength [lindex [measure hbonds $bond $angle $s($i) $s($j)] 0]]
#				puts $out1 "numH($i,$j) == $numH($i,$j)"
			}
		}
	}

#####################################
###Intra-molecular hydrogen bonds
#####################################
	for {set i $initr} {$i <= $finalr} {incr i} {
		set numHintra($i,$i) [llength [lindex [measure hbonds $bond $angle $s($i)] 0]]
	}

#####################################
###Inter-molecular hydrogen bonds summation
#####################################
	for {set i $initr} {$i <= $finalr} {incr i} {
		for {set j $initr} {$j <= $finalr} {incr j} {
			if {$i != $j} {
#				set sum($i) [expr $sum($i)+$numH($i,$j)]
				set sum($i) [expr $sum($i)+$numH($i,$j)+$numH($j,$i)]
			}
		}
	}
#####################################
###Total number of Intra-molecular H-bond 
#####################################
	for {set i $initr} {$i <= $finalr} {incr i} {
		set totintraH [expr $totintraH + $numHintra($i,$i)] 
	}

#	puts "frame == $frame"
#	puts "Total number of intra-molecular H-bond = $totintraH"
#####################################
###Total number of inter-molecular H-bond
#####################################
	for {set i $initr} {$i <= $finalr} {incr i} {
		set totH [expr $totH + $sum($i)]
	}
#	puts "Total number of inter-molecular H-bond = [expr $totH/2.0]"
#	puts "# of intra + # of inter H-bond = [expr [expr $totH/2.0] + $totintraH]"
#####################################
### Test prints
#####################################
	puts $out1 "frame == $frame"
	puts $out2 "frame == $frame"

	for {set i $initr} {$i <= $finalr} {incr i} {
		for {set j $initr} {$j <= $finalr} {incr j} {
			puts $out1 "numH($i,$j) == $numH($i,$j)"
		}
	}

	for {set i $initr} {$i <= $finalr} {incr i} {
		puts $out2 "numHintra($i,$i) == $numHintra($i,$i)"
	}

	puts $out3 "$frame	 [expr [expr $totH/2.0] + $totintraH]"
	puts $out4 "$frame [expr $totH/2.0]"
	puts $out5 "$frame $totintraH"

#	for {set i $initr} {$i <= $finalr} {incr i} {
#		puts "sum($i) == $sum($i)"
#	}
#####################################
### Reset all varialbes
#####################################
	set totintraH 0.0
	set totH 0.0

	for {set i $initr} {$i <= $finalr} {incr i} {
		for {set j $initr} {$j <= $finalr} {incr j} {
			set sum($i) 0.0
		}
	}

	for {set i $initr} {$i <= $finalr} {incr i} {
		for {set j $initr} {$j <= $finalr} {incr j} {
			set numH($i,$j) 0.0
		}
	}
#End of frame
}
close $out1
close $out2
close $out3
close $out4
close $out5
