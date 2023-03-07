#!/usr/bin/tclsh
set kc1 [atomselect top "resname KC1"]
set rotz [transabout {0 0 1} 180]

$kc1 move $rotz
$kc1 moveby {149 149 70}

