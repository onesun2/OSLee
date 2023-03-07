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
set ttt3 {}
set bond2 {}

set out [open count.dat w]

mol load psf gra.psf pdb gra.pdb
set all [atomselect top "all"]
set residlist [$all get resid] ;# list of resid of all carbon atom
set num [$all num]

set totox [expr int($num/5)]
puts "totox = $totox"
set limitcoc [expr 2*2*$totox/5] ;# we need double size for COC since the epoxy group needs two carbon sites
set limitcoh [expr 2*$totox/5]
set limitcoo [expr 1*$totox/5]
set coccount 0
set cohcount 0
set coocount 0
#puts "limitcoc = $limitcoc, limitcoh = $limitcoh"
#set limitcoc 0
#set limitcoh 1
####################################################################################
#### Edge and Side Carbond List: instead of $num, the -COOH group will use bond2 ###
####################################################################################
foreach el $residlist {
        set atemp($el) [atomselect top "resid $el"]
        if {[llength [lindex [$atemp($el) getbonds] 0]] == 2} {
                lappend bond2 $el
        }
}
set bond2num [llength $bond2]
###############################################################
proc myrand {num} {
	return [expr int($num*rand())]  ;# random integer number between 0 and num-1
}

while {[llength $ttt] < $limitcoc} {
	set rand1 [myrand $num] ;# sometimes resid is not sequential and we know only total number of carbon.
	set atom1 [lindex $residlist $rand1] ;# therefore, we call resid by its position in the list.
	if {[lsearch $ttt $atom1]<0} {
		lappend ttt $atom1
		set coccount [expr $coccount + 1]
			
		set atom2all [atomselect top "(within 2 of resid $atom1) and (not resid $atom1)"]
		set rand2 [myrand [$atom2all num]]
		set atom2 [lindex [$atom2all get resid] $rand2]
		if {[lsearch $ttt $atom2]<0} {
			lappend ttt $atom2
			puts $out "coccount $coccount"
			if {[expr $coccount%2]==0} {
				patch COC CCC:$atom1 CCC:$atom2
				puts $out "COC atom1 $atom1 atom2 $atom2"
			} else {
				patch COC2 CCC:$atom1 CCC:$atom2
				puts $out "COC2 atom1 $atom1 atom2 $atom2"
			}
		}
	}
}

while {[llength $ttt2] < $limitcoh} {
	set rand3 [myrand $num]
	set atom3 [lindex $residlist $rand3]
	if {([lsearch $ttt $atom3]<0) && ([lsearch $ttt2 $atom3]<0)} {
		lappend ttt2 $atom3
		set cohcount [expr $cohcount + 1]
		puts $out "cohcount $cohcount"

		if {[expr $cohcount%2]==0} {
			patch COH CCC:$atom3
			puts $out "COH atom3 $atom3"
		} else {
			patch COH2 CCC:$atom3
			puts $out "COH2 atom3 $atom3"
		}
	}
}

while {[llength $ttt3] < $limitcoo} {
#	set rand4 [myrand $num]
	set rand4 [myrand $bond2num]
#	set atom4 [lindex $residlist $rand4]
	set atom4 [lindex $bond2 $rand4]
	if {([lsearch $ttt $atom4]<0) && ([lsearch $ttt2 $atom4]<0) && ([lsearch $ttt3 $atom4]<0)} {
		lappend ttt3 $atom4
		set coocount [expr $coocount + 1]
		puts $out "coocount $coocount"

		if {[expr $coocount%2]==0} {
			patch CX1 CCC:$atom4
			puts $out "CX1 atom4 $atom4"
		} else {
			patch CX2 CCC:$atom4
			puts $out "CX2 atom4 $atom4"
		}
	}
}

guesscoord

writepsf temp1.psf
writepdb temp1.pdb

mol delete all
mol load psf temp1.psf pdb temp1.pdb
resetpsf
close $out
