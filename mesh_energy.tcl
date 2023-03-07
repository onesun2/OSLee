#!/usr/bin/tclsh
set dmin 0.0
set dmax 5.0
set dstep 0.1
set amin 0.0
set amax 180.0
set astep 2.0
set esum 0.0
set qsum 0.0
set f [open [lindex $argv 0] r]
set out [open mesh_energy_surf.out w]
######################################################
#fincr is a floating point version of standard incr ##
######################################################
proc fincr {varName {amount $binsize}} {
	upvar $varName var
	if [info exist var] {
		set var [expr $var + $amount]
	} else {
		set var $amount
	}
	return $var
}
######################################################
for {set d $dmin} {$d <= $dmax} {fincr d $dstep} {
	for {set a $amin} {$a <= $amax} {fincr a $astep} {
		set arr($d,$a) {}
	}
}

for {set d $dmin} {$d <= $dmax} {fincr d $dstep} {
	for {set a $amin} {$a <= $amax} {fincr a $astep} {
		set ttt($d,$a) 0.0 
	}
}

while {[gets $f line] >= 0} {
	set dist [lindex $line 0]
	set ang [lindex $line 1]
	set ene [lindex $line 2]

	for {set d $dmin} {$d < $dmax} {fincr d $dstep} {
		for {set a $amin} {$a <= $amax} {fincr a $astep} {
			if {$dist > $d && $dist <= [expr $d+$dstep] && $ang > $a && $ang <= [expr $a+$astep]} {
				lappend arr($d,$a) $ene	
			}
		}
	}
}

for {set d $dmin} {$d <= $dmax} {fincr d $dstep} {
	for {set a $amin} {$a <= $amax} {fincr a $astep} {
		if {[llength $arr($d,$a)] >0} {
#			puts "d=$d,a=$a,val=$arr($d,$a)"
			foreach ele $arr($d,$a) {
				set en [expr $ele*exp(-$ele/0.6)]
				set esum [expr $esum +$en]
#				puts "en = $en, esum = $esum"
				set qn [expr exp(-$ele/0.6)]
				set qsum [expr $qsum +$qn]
#				puts "qn = $qn, qsum = $qsum"
			}
			set ttt($d,$a) [expr $esum/$qsum]
#			puts "ene =$ttt($d,$a)"
#			puts ""
			set esum 0.0
			set qsum 0.0
		}
	}
}

for {set d $dmin} {$d <=$dmax} {fincr d $dstep} {
	for {set a $amin} {$a <= $amax} {fincr a $astep} {
		puts $out [format "%8.4f " $ttt($d,$a)] nonewline
#		puts $out "$ttt($d,$a) " nonewline 
	}
	puts $out ""
}
close $f
close $out
