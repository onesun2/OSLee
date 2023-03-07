#!/usr/bin/tclsh
for {set i 1} {$i <= 18} {incr i} {
	set res$i [atomselect top "resid $i"]
}
for {set i 1} {$i <= 18} {incr i} {
	set sel$i [atomselect top "resid $i and (name CA1 CA2 CA3 CA4 CA5 CA6)"]
}

set cen(1) [measure center $sel1]
set cen(2) [measure center $sel2]
set cen(3) [measure center $sel3]
set cen(4) [measure center $sel4]
set cen(5) [measure center $sel5]
set cen(6) [measure center $sel6]
set cen(7) [measure center $sel7]
set cen(8) [measure center $sel8]
set cen(9) [measure center $sel9]
set cen(10) [measure center $sel10]
set cen(11) [measure center $sel11]
set cen(12) [measure center $sel12]
set cen(13) [measure center $sel13]
set cen(14) [measure center $sel14]
set cen(15) [measure center $sel15]
set cen(16) [measure center $sel16]
set cen(17) [measure center $sel17]
set cen(18) [measure center $sel18]

set tv(1) [vecsub {-3.10 5.37 5.67} $cen(1)]
set tv(2) [vecsub {3.10 5.37 5.00} $cen(2)]
set tv(3) [vecsub {6.20 0.00 4.33} $cen(3)]
set tv(4) [vecsub {3.10 -5.37 3.67} $cen(4)]
set tv(5) [vecsub {-3.10 -5.37 3.00} $cen(5)]
set tv(6) [vecsub {-6.20 0.00 2.33} $cen(6)]
set tv(7) [vecsub {-3.10 5.37 1.67} $cen(7)]
set tv(8) [vecsub {3.10 5.37 1.00} $cen(8)]
set tv(9) [vecsub {6.20 0.00 0.33} $cen(9)]
set tv(10) [vecsub {3.10 -5.37 -0.33} $cen(10)]
set tv(11) [vecsub {-3.10 -5.37 -1.00} $cen(11)]
set tv(12) [vecsub {-6.20 0.00 -1.67} $cen(12)]
set tv(13) [vecsub {-3.10 5.37 -2.33} $cen(13)]
set tv(14) [vecsub {3.10 5.37 -3.00} $cen(14)]
set tv(15) [vecsub {6.20 0.00 -3.67} $cen(15)]
set tv(16) [vecsub {3.10 -5.37 -4.33} $cen(16)]
set tv(17) [vecsub {-3.10 -5.37 -5.00} $cen(17)]
set tv(18) [vecsub {-6.20 0.00 -5.67} $cen(18)]

$res1 moveby $tv(1)
$res2 moveby $tv(2)
$res3 moveby $tv(3)
$res4 moveby $tv(4)
$res5 moveby $tv(5)
$res6 moveby $tv(6)
$res7 moveby $tv(7)
$res8 moveby $tv(8)
$res9 moveby $tv(9)
$res10 moveby $tv(10)
$res11 moveby $tv(11)
$res12 moveby $tv(12)
$res13 moveby $tv(13)
$res14 moveby $tv(14)
$res15 moveby $tv(15)
$res16 moveby $tv(16)
$res17 moveby $tv(17)
$res18 moveby $tv(18)


