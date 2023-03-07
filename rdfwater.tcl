#!/usr/bin/tclsh
set out1 [open wrdf.dat w]
#set num_steps [molinfo top get numframes]
#set wat [atomselect top "name OH2 and x*x+y*y< 1936"]
set pi 3.1415926535897931
proc fincr {varName {amount $binsize}} {
        upvar $varName var
        if [info exist var] {
                set var [expr $var + $amount]
        } else {
                set var $amount
        }
        return $var
}

for {set i 0} {$i < 50} {fincr i 0.2} {
	set in [expr $i*$i]
	set out [expr ($i+0.2)*($i+0.2)]
	set vol [expr $pi*75*(($i+0.2)*($i+0.2)-$i*$i)]
	set wat [atomselect top "name OH2 and ((x*x+y*y>= $in) and (x*x+y*y<$out))"]
	puts $out1 "$i [expr [$wat num]/$vol]"
	$wat delete
}
close $out1
