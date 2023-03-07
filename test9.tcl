#######################################################
### Script for Generating Graphene Oxide from      ####
### raw graphene sheet  ###############################
#######################################################
###   One-Sun Lee       ###############################
###   January 2017      ###############################
###   QEERI, HBKU       ###############################
#######################################################
#  Before source this script, you need to type     ####
#  topology top_water.inp in VMD console, then     ####
#  you have to source this script in VMD console.  ####
#######################################################
mol delete all
readpsf gra.psf
coordpdb gra.pdb

set ttt {}
set ttt2 {}

mol load psf gra.psf pdb gra.pdb
set all [atomselect top "all"]
set residlist [$all get resid] ;# list of resid of all carbon atom
set num [$all num]

set totox [expr int($num/5)]
puts "totox = $totox"
set limitcoc [expr 2*2*$totox/5]
set limitcoh [expr 3*$totox/5]
#puts "limitcoc = $limitcoc, limitcoh = $limitcoh"
#set limitcoc 0
#set limitcoh 1

proc myrand {num} {
	return [expr int($num*rand())]  ;# random integer number between 0 and num-1
}

while {[llength $ttt] < $limitcoc} {
	set rand1 [myrand $num] ;# sometimes resid is not sequential and we know only total number of carbon.
	set atom1 [lindex $residlist $rand1] ;# therefore, we call resid by its position in the list.
	if {[lsearch $ttt $atom1]<0} {
		lappend ttt $atom1
	
		set atom2all [atomselect top "(within 2 of resid $atom1) and (not resid $atom1)"]
		set rand2 [myrand [$atom2all num]]
		set atom2 [lindex [$atom2all get resid] $rand2]
		if {[lsearch $ttt $atom2]<0} {
			lappend ttt $atom2
			if {[expr $atom2%2]==0} {
				patch COC CCC:$atom1 CCC:$atom2
			} else {
				patch COC2 CCC:$atom1 CCC:$atom2
			}
		}
	}
}

while {[llength $ttt2] < $limitcoh} {
	set rand3 [myrand $num]
	set atom3 [lindex $residlist $rand3]
	if {([lsearch $ttt $atom3]<0) && ([lsearch $ttt2 $atom3]<0)} {
		lappend ttt2 $atom3
		if {[expr $atom3%2]==0} {
			patch COH CCC:$atom3
		} else {
			patch COH2 CCC:$atom3
		}
	}
}
guesscoord

writepsf ttt9.psf
writepdb ttt9.pdb

mol delete all
mol load psf ttt9.psf pdb ttt9.pdb
resetpsf

