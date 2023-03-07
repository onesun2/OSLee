#!/usr/bin/tclsh

#####################################
### Definition of variables
#####################################
set num_steps [molinfo top get numframes]
set initr 1	;# first segname S1
set finalr 144	;# last segname S144
set out1 [open hbond_list.out w]
set out2 [open final_array.out w]
set bond 3.0
set angle 20.0

for {set i $initr} {$i <= $finalr} {incr i} {
	set s($i) [atomselect top "segname S$i"]	
}

for {set i 0} {$i <= 12} {incr i} {
	for {set j 0} {$j <= 12} {incr j} {
		set hbond_residue($i,$j) 0.0
	}
}

#####################################
### End of definition of variables
#####################################

############################################################
### Main
############################################################
for {set frame 0} {$frame < $num_steps} {incr frame} {
	puts $out1 "frame = $frame"

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

				if {$numH($i,$j) > 0} {
					puts $out1 "segname_S$i, S$j == $numH($i,$j)"
					for {set k 0} {$k < $numH($i,$j)} {incr k} {
						set d_idx [lindex [measure hbonds $bond $angle $s($i) $s($j)] 0]
						set d_idx_k [lindex $d_idx $k]
						set donor [atomselect top "index $d_idx_k"]
						set d_resid [$donor get resid]

						set a_idx [lindex [measure hbonds $bond $angle $s($i) $s($j)] 1]
						set a_idx_k [lindex $a_idx $k]
						set acceptor [atomselect top "index $a_idx_k"]
						set a_resid [$acceptor get resid]
#						puts $out1 "hbond($i, $j) == 1"
#						puts $out1 "hbond_residue($d_resid,$a_resid) == 1"
						set hbond_residue($d_resid,$a_resid) [expr $hbond_residue($d_resid,$a_resid)+1.0]
						puts $out1 "hbond_residue($d_resid,$a_resid) == [expr $hbond_residue($d_resid,$a_resid)+1.0]"
						$donor delete
						$acceptor delete
					}
				} elseif {$numH($i,$j) == 0} {
#					puts $out1 "hbond($i, $j) == 0"
				}


			}
		}
	}

}


for {set i 0} {$i <= 12} {incr i} {
	for {set j 0} {$j <= 12} {incr j} {
		puts $out1 [format "hbond_residue(%2d,%2d) = %10.1f" $i $j $hbond_residue($i,$j)] 
#		puts $out2 [format "hbond_residue(%2d,%2d) = %10.1f " $i $j $hbond_residue($i,$j)] nonewline
		puts $out2 [format "%10.1f" $hbond_residue($i,$j)] nonewline
		if {$j%13 == 12} {
			puts $out2 ""
		}
	}
}

close $out1
close $out2
