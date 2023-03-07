#!/usr/bin/tclsh
set out [open thermalconductivity.dat w]

puts "Enter Q (kcal/mol): "
gets stdin qqq
puts "You entered: $qqq"

puts "Enter x (Aungstrom): "
gets stdin xx
puts "You entered: $xx"

puts "Enter y (Aungstrom): "
gets stdin yy
puts "You entered: $yy"

puts "Enter z (Aungstrom): "
gets stdin zz
puts "You entered: $zz"

puts "Enter time (fs): "
gets stdin time 
puts "You entered: $time"

puts "Enter Temperature difference (K): "
gets stdin temp 
puts "You entered: $temp"

#puts "a times b is [expr $aaa*$bbb]"
set solution [expr ($qqq/(2*$xx*$yy*$time))*($zz/(2*$temp))]
set thermal_cond [expr 69501.7*$solution]
puts "thermal conductivity is $thermal_cond W/(mK)"
puts $out "thermal conductivity is $thermal_cond W/(mK)"
close $out

