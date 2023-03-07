#!/usr/bin/tclsh
set PI 3.1415926535897932384626

set caps [atomselect top "(name CC1 to CC6) or (name C01 to C36)"]
set upper [atomselect top "name CC1 CC2 CC3"]
set down [atomselect top "name CC4 CC5 CC6"]
set xe [atomselect top "segname XE1"]

proc geom_center {selection} {
        set gc [veczero]
        foreach coord [$selection get {x y z}] {
                set gc [vecadd $gc $coord]
        }
        return [vecscale [expr 1.0/[$selection num]] $gc]
}

set c1 [geom_center $caps]
set uc [geom_center $upper]
set dc [geom_center $down]
set cxe [geom_center $xe]

puts "center of cryp = $c1"
puts "center of upper cap = $uc"
puts "center of down cap = $dc"
puts "center of xe = $cxe"
