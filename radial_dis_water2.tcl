#!/usr/bin/tclsh
package require Tcl 8
package require math::statistics
#########################################
####fincr                              ##
#########################################
proc fincr {varName {amount $binsize}} {
        upvar $varName var
        if [info exist var] {
                set var [expr $var + $amount]
        } else {
                set var $amount
        }
        return $var
}
###########################################
set pi 3.141592265358979323846264338327950288419716939937510
set height 93.1
set init 4
set final 70
set stepsize 1.0
set out [open dist2.dat w]
set num_steps [molinfo top get numframes]
for {set i $init} {$i <=$final} {fincr i $stepsize} {
	set nwater($i) [atomselect top "name OH2 and (x*x+y*y > [expr $i*$i]) and (x*x+y*y < [expr ($i+1)*($i+1)])"]
}
for {set k $init} {$k <= $final} {fincr k $stepsize} {
	set sum($k) {} 
}

###################################################################
###           MAIN                                             ####
###################################################################
for {set frame 0} {$frame < $num_steps} {incr frame} {
	for {set i $init} {$i <=$final} {fincr i $stepsize} {
		$nwater($i) frame $frame
		$nwater($i) update
	}
	for {set j $init} {$j <= $final} {fincr j $stepsize} {
		set sum($j) [lappend sum($j) [$nwater($j) num]]
#		puts $out "$frame, sum($j) = $sum($j)"
	}
}

for {set j $init} {$j <= $final} {fincr j $stepsize} {
	set avg [::math::statistics::mean $sum($j)]
	set std [::math::statistics::stdev $sum($j)]
	set vol [expr $height*$pi*(($j+$stepsize)*($j+$stepsize)-$j*$j)]
	puts $out [format "%5.2f %12.6f %12.6f" $j [expr $avg/$vol] [expr $std/$vol]]  
}
close $out
