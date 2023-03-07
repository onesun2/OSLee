#!/usr/bin/tclsh
set num_line 30000
set f [open [lindex $argv 0] r]
for {set i 0} { $i < $num_line} {incr i} {
        gets $f line
        for {set j 0} {$j < 500} {incr j} {
                set matrix($i,$j) [lindex $line $j]
        }
}

set sum 0.0

for {set j 0} {$j < 500} {incr j} {
	set n 0
        for {set i 0} {$i < $num_line} {incr i} {
                set el $matrix($i,$j)
		if {$el == 1} {
                	set sum [expr $el + $sum]
			if {$i == [expr $num_line-1]} {
				puts "j = $j, n = $n, sum = $sum"
                        	set sum 0.0
			}
		} elseif {$el == 0 && $sum > 0} {
			puts "j = $j, n = $n, sum = $sum"
			incr n
			set sum 0.0
		} 
        }
        set sum 0.0
}
