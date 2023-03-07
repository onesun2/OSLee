readpsf ttt9.psf
coordpdb ttt9.pdb

mol load psf ttt9.psf pdb ttt9.pdb

set templist {}
set out [open data.dat w]
set all [atomselect top "all"]
set ttt [atomselect top "type CNT CNO"]
set list1 [$ttt get index]

for {set i 0} {$i <[$ttt num]} {incr i} {
	set idx1 [lindex $list1 $i]
	set a($idx1) [atomselect top "index $idx1"]
	set temp2 [$a($idx1) getbonds]
	set bondlist  [lindex $temp2 0]
#	set bondorder [llength [lindex $temp2 0]]
	set n 0
	foreach el $bondlist {
		set subatom($el) [atomselect top "index $el"]
		if {[string equal [$subatom($el) get type] CNT] == 1 || [string equal [$subatom($el) get type] CNO] == 1} {
			set n [expr $n+1]
		}
	}
	if {$n == 2 && [string equal [$a($idx1) get type] CNT] == 1} {
		set resid [$a($idx1) get resid]
		lappend templist $idx1
		patch CTH CCC:$resid
	} elseif {$n == 2 && [string equal [$a($idx1) get type] CNO] == 1} {
		set resid [$a($idx1) get resid]
		lappend templist $idx1
		patch CTH2 CCC:$resid
	}
	set n 0
}
puts $out "$templist"
close $out

guesscoord

writepsf temp2.psf
writepdb temp2.pdb

mol delete all
mol load psf temp2.psf pdb temp2.pdb
resetpsf

