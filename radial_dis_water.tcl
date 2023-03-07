#!/usr/bin/tclsh
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
set init 4
set final 10
set stepsize 0.1
set filename "sntest2.txt"
set fileId [open $filename "w"]
set num_steps [molinfo top get numframes]
for {set i $init} {$i <=$final} {fincr i $stepsize} {
	set nwater($i) [atomselect top "name OH2 and (x*x+y*y > [expr $i*$i]) and (x*x+y*y < [expr ($i+1)*($i+1)]) and (z > -80 and z <80)"]
#	puts "i = $i; i*i = [expr $i*$i], (i+1)*(i+1) = [expr ($i+1)*($i+1)]"
}
for {set k $init} {$k <= $final} {fincr k $stepsize} {
	set sum($k) 0.0
}

###################################################################
###           MAIN                                             ####
###################################################################
for {set frame 0} {$frame < $num_steps} {incr frame} {
#	puts $fileId "frame = $frame"
	for {set i $init} {$i <=$final} {fincr i $stepsize} {
		$nwater($i) frame $frame
		$nwater($i) update
	}
	for {set j $init} {$j <= $final} {fincr j $stepsize} {
		set sum($j) [expr $sum($j)+[$nwater($j) num]]
#		puts $fileId "nwater($j) = [$nwater($j) num]"
	}
}
for {set j $init} {$j <= $final} {fincr j $stepsize} {
#	puts $fileId "sum_nwater($j) = [expr $sum($j)/$num_steps]"
	puts $fileId [format "sum_nwater(%5.2f) = %12.3f" $j [expr $sum($j)/$num_steps]]  
}
close $fileId
