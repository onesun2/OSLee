#!/usr/bin/tclsh
	set seed1 [expr int(349*rand())]
	set atom1 [atomselect top "index $seed1"]
	set atom2a [atomselect top "(within 2 of index $seed1) and (not index $seed1)"]
	set length2 [llength [$atom2a get index]]
	set rand1 [expr int($length2*rand())]
	set seed2 [lindex [$atom2a get index] $rand1]
	puts "seed1 = $seed1, seed2 = $seed2"
