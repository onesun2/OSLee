#!/usr/bin/tclsh
set fileId1 [open cra_z1112PMF.dat "w"]
set n 0
set f1 [open ./block1/plot4.plot r]
set f2 [open ./block2/plot4.plot r]
set f3 [open ./block3/plot4.plot r]

puts $fileId1 "   position      F2                Fexp            stdev(F2)          stdev(Fexp)" 

for {set number 0} {$number <= 50000} {incr number} {
	gets $f1 line1
	gets $f2 line2
	gets $f3 line3

	set pos [lindex $line1 0]
	set f2a [lindex $line1 2]
	set fexpa [lindex $line1 3]

	set f2b [lindex $line2 2]
	set fexpb [lindex $line2 3]

	set f2c [lindex $line3 2]
	set fexpc [lindex $line3 3]

#	set f2av [expr ($f2a+$f2b+$f2c)/3]
#	set fexpav [expr ($fexpa+$fexpb+$fexpc)/3]
#	set stdev1 [expr (sqrt(($f2av-$f2a)*($f2av-$f2a)+($f2av-$f2b)*($f2av-$f2b)+($f2av-$f2c)*($f2av-$f2c)))/3]
#	set stdev2 [expr (sqrt(($fexpav-$fexpa)*($fexpav-$fexpa)+($fexpav-$fexpb)*($fexpav-$fexpb)+($fexpav-$fexpc)*($fexpav-$fexpc)))/3]

	if {$n%25000 == 0} {
		set f2av [expr ($f2a+$f2b+$f2c)/3]
		set fexpav [expr ($fexpa+$fexpb+$fexpc)/3]
		set stdev1 [expr (sqrt(($f2av-$f2a)*($f2av-$f2a)+($f2av-$f2b)*($f2av-$f2b)+($f2av-$f2c)*($f2av-$f2c)))/3]
		set stdev2 [expr (sqrt(($fexpav-$fexpa)*($fexpav-$fexpa)+($fexpav-$fexpb)*($fexpav-$fexpb)+($fexpav-$fexpc)*($fexpav-$fexpc)))/3]
		puts $fileId1 [format "%15.7f %15.9f %15.9f %15.9f %15.9f" $pos $f2av $fexpav $stdev1 $stdev2]
	} elseif {$n%100 == 0} {
		set f2av [expr ($f2a+$f2b+$f2c)/3]
		set fexpav [expr ($fexpa+$fexpb+$fexpc)/3]
		puts $fileId1 [format "%15.7f %15.9f %15.9f          0.0             0.0" $pos $f2av $fexpav]
	}
	incr n
}
close $fileId1
close $f1
close $f2
close $f3
