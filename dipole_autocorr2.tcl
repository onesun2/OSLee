#!/usr/bin/tclsh
package require Tcl 8
package require math::statistics
set ff [open [lindex $argv 0] r]
set out [open autocorrelation_dipole.dat w]
set n 0
set yy {}
set sum 0.0
while {[gets $ff line] >= 0} {
	set v($n) {}
	set ele1 [lindex $line 1] 
	set ele2 [lindex $line 2] 
	set ele3 [lindex $line 3] 
	set ele4 [lindex $line 4] 
	lappend v($n) [expr $ele1/$ele4]
	lappend v($n) [expr $ele2/$ele4]
	lappend v($n) [expr $ele3/$ele4]
#	puts $out "$v($n)"
	lappend yy $v($n)
	set n [expr $n+1]
}

for {set h 0} {$h <= [expr $n-1]} {incr h} {
        for {set l 0} {$l <= [expr (($n-1) - $h)]} {incr l} {
                set t [expr $h + $l]
                set a [lindex $yy $t]
                set b [lindex $yy $l]
		set x1 [lindex $a 0]
		set y1 [lindex $a 1]
		set z1 [lindex $a 2]
		set x2 [lindex $b 0]
		set y2 [lindex $b 1]
		set z2 [lindex $b 2]
		set dotprod [expr $x1*$x2+$y1*$y2+$z1*$z2]
		set sum [expr $sum+$dotprod]
	}
	if {$h==0} {
		set norm $sum	
	}
#	puts $out "acf = [expr $sum/$norm]"
	puts $out "$h [expr $sum/$norm]"
	set sum 0.0
}
#puts $out "norm = $norm"
#foreach i $yy {
#	puts $out "$i"
#}
close $out
