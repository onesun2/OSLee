#!/usr/bin/tclsh

set num_steps [molinfo top get numframes]
set alphadata {28 29 32 33 52 61 64 65 84 93 96 97 116 125 128 129 148 157 160 161 \
180 189 192 193 212 221 224 225 244 253 256 257 276 285 288 289 308 321 324 325 \
370 371 374 375 394 403 406 407 426 435 438 439 458 467 470 471 490 499 502 503 \
522 531 534 535 554 563 566 567 586 595 598 599 618 627 630 631 650 663 666 667 \
712 713 716 717 736 745 748 749 768 777 780 781 800 809 812 813 832 841 844 845 \
864 873 876 877 896 905 908 909 928 937 940 941 960 969 972 973 992 1005 1008 1009 \
1054 1055 1058 1059 1078 1087 1090 1091 1110 1119 1122 1123 1142 1151 1154 1155 1174 1183 1186 1187 \
1206 1215 1218 1219 1238 1247 1250 1251 1270 1279 1282 1283 1302 1311 1314 1315 1334 1347 1350 1351}

foreach i $alphadata {
	set a($i) [atomselect top "index $i"]
}

set fileId3 [open alphatest.dat w]

proc signed_angle { a b c } {
  set amag [veclength $a]
  set bmag [veclength $b]
  set dotprod [vecdot $a $b]

  set crossp [veccross $a $b]
  set sign [vecdot $crossp $c]
  if { $sign < 0 } {
    set sign -1
  } else {
    set sign 1
  }
  set temp [expr $dotprod / ($amag * $bmag)]
  if { $temp > 1 } {
	set temp 1
  } elseif { $temp < -1 } {
	set temp -1
  }
#  return [expr $sign * 57.2958 * acos($dotprod / ($amag * $bmag))]
  return [expr $sign * 57.2958 * acos($temp)]
}

proc dihedral { a1 a2 a3 a4 } {
  if {[llength $a1] != 3 || [llength $a2] != 3 || [llength $a3] != 3 || [llength $a4] != 3} {
    return 0
  }

  set r1 [vecsub $a1 $a2]
  set r2 [vecsub $a3 $a2]
  set r3 [vecscale $r2 -1]
  set r4 [vecsub $a4 $a3]

  set n1 [veccross $r1 $r2]
  set n2 [veccross $r3 $r4]

  return [signed_angle $n1 $n2 $r2]
}

proc geom_center {selection} {
	set gc [veczero]
	foreach coord [$selection get {x y z}] {
		set gc [vecadd $gc $coord]
	}
	return [vecscale [expr 1.0/[$selection num]] $gc]
}

for {set frame 0} {$frame < $num_steps} {incr frame} {

	foreach i $alphadata {
		$a($i) frame $frame
	}

	set alpha10 [dihedral [geom_center $a(28)] [geom_center $a(29)] [geom_center $a(32)] [geom_center $a(33)]] 
	set alpha11 [dihedral [geom_center $a(52)] [geom_center $a(61)] [geom_center $a(64)] [geom_center $a(65)]] 
	set alpha12 [dihedral [geom_center $a(84)] [geom_center $a(93)] [geom_center $a(96)] [geom_center $a(97)]] 
	set alpha13 [dihedral [geom_center $a(116)] [geom_center $a(125)] [geom_center $a(128)] [geom_center $a(129)]] 
	set alpha14 [dihedral [geom_center $a(148)] [geom_center $a(157)] [geom_center $a(160)] [geom_center $a(161)]] 
	set alpha15 [dihedral [geom_center $a(180)] [geom_center $a(189)] [geom_center $a(192)] [geom_center $a(193)]] 
	set alpha16 [dihedral [geom_center $a(212)] [geom_center $a(221)] [geom_center $a(224)] [geom_center $a(225)]] 
	set alpha17 [dihedral [geom_center $a(244)] [geom_center $a(253)] [geom_center $a(256)] [geom_center $a(257)]] 
	set alpha18 [dihedral [geom_center $a(276)] [geom_center $a(285)] [geom_center $a(288)] [geom_center $a(289)]] 
	set alpha19 [dihedral [geom_center $a(308)] [geom_center $a(321)] [geom_center $a(324)] [geom_center $a(325)]] 

	set alpha20 [dihedral [geom_center $a(370)] [geom_center $a(371)] [geom_center $a(374)] [geom_center $a(375)]] 
	set alpha21 [dihedral [geom_center $a(394)] [geom_center $a(403)] [geom_center $a(406)] [geom_center $a(407)]] 
	set alpha22 [dihedral [geom_center $a(426)] [geom_center $a(435)] [geom_center $a(438)] [geom_center $a(439)]] 
	set alpha23 [dihedral [geom_center $a(458)] [geom_center $a(467)] [geom_center $a(470)] [geom_center $a(471)]] 
	set alpha24 [dihedral [geom_center $a(490)] [geom_center $a(499)] [geom_center $a(502)] [geom_center $a(503)]] 
	set alpha25 [dihedral [geom_center $a(522)] [geom_center $a(531)] [geom_center $a(534)] [geom_center $a(535)]] 
	set alpha26 [dihedral [geom_center $a(554)] [geom_center $a(563)] [geom_center $a(566)] [geom_center $a(567)]] 
	set alpha27 [dihedral [geom_center $a(586)] [geom_center $a(595)] [geom_center $a(598)] [geom_center $a(599)]] 
	set alpha28 [dihedral [geom_center $a(618)] [geom_center $a(627)] [geom_center $a(630)] [geom_center $a(631)]] 
	set alpha29 [dihedral [geom_center $a(650)] [geom_center $a(663)] [geom_center $a(666)] [geom_center $a(667)]] 

	set alpha30 [dihedral [geom_center $a(712)] [geom_center $a(713)] [geom_center $a(716)] [geom_center $a(717)]] 
	set alpha31 [dihedral [geom_center $a(736)] [geom_center $a(745)] [geom_center $a(748)] [geom_center $a(749)]] 
	set alpha32 [dihedral [geom_center $a(768)] [geom_center $a(777)] [geom_center $a(780)] [geom_center $a(781)]] 
	set alpha33 [dihedral [geom_center $a(800)] [geom_center $a(809)] [geom_center $a(812)] [geom_center $a(813)]] 
	set alpha34 [dihedral [geom_center $a(832)] [geom_center $a(841)] [geom_center $a(844)] [geom_center $a(845)]] 
	set alpha35 [dihedral [geom_center $a(864)] [geom_center $a(873)] [geom_center $a(876)] [geom_center $a(877)]] 
	set alpha36 [dihedral [geom_center $a(896)] [geom_center $a(905)] [geom_center $a(908)] [geom_center $a(909)]] 
	set alpha37 [dihedral [geom_center $a(928)] [geom_center $a(937)] [geom_center $a(940)] [geom_center $a(941)]] 
	set alpha38 [dihedral [geom_center $a(960)] [geom_center $a(969)] [geom_center $a(972)] [geom_center $a(973)]] 
	set alpha39 [dihedral [geom_center $a(992)] [geom_center $a(1005)] [geom_center $a(1008)] [geom_center $a(1009)]] 

	set alpha40 [dihedral [geom_center $a(1054)] [geom_center $a(1055)] [geom_center $a(1058)] [geom_center $a(1059)]] 
	set alpha41 [dihedral [geom_center $a(1078)] [geom_center $a(1087)] [geom_center $a(1090)] [geom_center $a(1091)]] 
	set alpha42 [dihedral [geom_center $a(1110)] [geom_center $a(1119)] [geom_center $a(1122)] [geom_center $a(1123)]] 
	set alpha43 [dihedral [geom_center $a(1142)] [geom_center $a(1151)] [geom_center $a(1154)] [geom_center $a(1155)]] 
	set alpha44 [dihedral [geom_center $a(1174)] [geom_center $a(1183)] [geom_center $a(1186)] [geom_center $a(1187)]] 
	set alpha45 [dihedral [geom_center $a(1206)] [geom_center $a(1215)] [geom_center $a(1218)] [geom_center $a(1219)]] 
	set alpha46 [dihedral [geom_center $a(1238)] [geom_center $a(1247)] [geom_center $a(1250)] [geom_center $a(1251)]] 
	set alpha47 [dihedral [geom_center $a(1270)] [geom_center $a(1279)] [geom_center $a(1282)] [geom_center $a(1283)]] 
	set alpha48 [dihedral [geom_center $a(1302)] [geom_center $a(1311)] [geom_center $a(1314)] [geom_center $a(1315)]] 
	set alpha49 [dihedral [geom_center $a(1334)] [geom_center $a(1347)] [geom_center $a(1350)] [geom_center $a(1351)]] 

	puts $fileId3 $alpha10
	puts $fileId3 $alpha11
	puts $fileId3 $alpha12
	puts $fileId3 $alpha13
	puts $fileId3 $alpha14
	puts $fileId3 $alpha15
	puts $fileId3 $alpha16
	puts $fileId3 $alpha17
	puts $fileId3 $alpha18
	puts $fileId3 $alpha19

	puts $fileId3 $alpha20
	puts $fileId3 $alpha21
	puts $fileId3 $alpha22
	puts $fileId3 $alpha23
	puts $fileId3 $alpha24
	puts $fileId3 $alpha25
	puts $fileId3 $alpha26
	puts $fileId3 $alpha27
	puts $fileId3 $alpha28
	puts $fileId3 $alpha29

	puts $fileId3 $alpha30
	puts $fileId3 $alpha31
	puts $fileId3 $alpha32
	puts $fileId3 $alpha33
	puts $fileId3 $alpha34
	puts $fileId3 $alpha35
	puts $fileId3 $alpha36
	puts $fileId3 $alpha37
	puts $fileId3 $alpha38
	puts $fileId3 $alpha39

	puts $fileId3 $alpha40
	puts $fileId3 $alpha41
	puts $fileId3 $alpha42
	puts $fileId3 $alpha43
	puts $fileId3 $alpha44
	puts $fileId3 $alpha45
	puts $fileId3 $alpha46
	puts $fileId3 $alpha47
	puts $fileId3 $alpha48
	puts $fileId3 $alpha49

}
close $fileId3
