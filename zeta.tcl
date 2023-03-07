#!/usr/bin/tclsh

set num_steps [molinfo top get numframes]
set zetadata { 50 52 61 64\
 82 84 93 96\
 114 116 125 128\
 146 148 157 160\
 178 180 189 192\
 210 212 221 224\
 242 244 253 256\
 274 276 285 288\
 306 308 321 324\
 392 394 403 406\
 424 426 435 438\
 456 458 467 470\
 488 490 499 502\
 520 522 531 534\
 552 554 563 566\
 584 586 595 598\
 616 618 627 630\
 648 650 663 666\
 734 736 745 748\
 766 768 777 780\
 798 800 809 812\
 830 832 841 844\
 862 864 873 876\
 894 896 905 908\
 926 928 937 940\
 958 960 969 972\
 990 992 1005 1008\
 1076 1078 1087 1090\
 1108 1110 1119 1122\
 1140 1142 1151 1154\
 1172 1174 1183 1186\
 1204 1206 1215 1218\
 1236 1238 1247 1250\
 1268 1270 1279 1282\
 1300 1302 1311 1314\
 1332 1334 1347 1350}

foreach i $zetadata {
	set a($i) [atomselect top "index $i"]
}

set fileId3 [open zetatest.dat w]

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

	foreach i $zetadata {
		$a($i) frame $frame
	}

	set zeta10 [dihedral  [geom_center $a(50)] [geom_center $a(52)] [geom_center $a(61)] [geom_center $a(64)] ] 
	set zeta11 [dihedral  [geom_center $a(82)] [geom_center $a(84)] [geom_center $a(93)] [geom_center $a(96)] ] 
	set zeta12 [dihedral  [geom_center $a(114)] [geom_center $a(116)] [geom_center $a(125)] [geom_center $a(128)] ] 
	set zeta13 [dihedral  [geom_center $a(146)] [geom_center $a(148)] [geom_center $a(157)] [geom_center $a(160)] ] 
	set zeta14 [dihedral  [geom_center $a(178)] [geom_center $a(180)] [geom_center $a(189)] [geom_center $a(192)] ] 
	set zeta15 [dihedral  [geom_center $a(210)] [geom_center $a(212)] [geom_center $a(221)] [geom_center $a(224)] ] 
	set zeta16 [dihedral  [geom_center $a(242)] [geom_center $a(244)] [geom_center $a(253)] [geom_center $a(256)] ] 
	set zeta17 [dihedral  [geom_center $a(274)] [geom_center $a(276)] [geom_center $a(285)] [geom_center $a(288)] ] 
	set zeta18 [dihedral  [geom_center $a(306)] [geom_center $a(308)] [geom_center $a(321)] [geom_center $a(324)] ] 

	set zeta20 [dihedral  [geom_center $a(392)] [geom_center $a(394)] [geom_center $a(403)] [geom_center $a(406)] ] 
	set zeta21 [dihedral  [geom_center $a(424)] [geom_center $a(426)] [geom_center $a(435)] [geom_center $a(438)] ] 
	set zeta22 [dihedral  [geom_center $a(456)] [geom_center $a(458)] [geom_center $a(467)] [geom_center $a(470)] ] 
	set zeta23 [dihedral  [geom_center $a(488)] [geom_center $a(490)] [geom_center $a(499)] [geom_center $a(502)] ] 
	set zeta24 [dihedral  [geom_center $a(520)] [geom_center $a(522)] [geom_center $a(531)] [geom_center $a(534)] ] 
	set zeta25 [dihedral  [geom_center $a(552)] [geom_center $a(554)] [geom_center $a(563)] [geom_center $a(566)] ] 
	set zeta26 [dihedral  [geom_center $a(584)] [geom_center $a(586)] [geom_center $a(595)] [geom_center $a(598)] ] 
	set zeta27 [dihedral  [geom_center $a(616)] [geom_center $a(618)] [geom_center $a(627)] [geom_center $a(630)] ] 
	set zeta28 [dihedral  [geom_center $a(648)] [geom_center $a(650)] [geom_center $a(663)] [geom_center $a(666)] ] 

	set zeta30 [dihedral  [geom_center $a(734)] [geom_center $a(736)] [geom_center $a(745)] [geom_center $a(748)] ] 
	set zeta31 [dihedral  [geom_center $a(766)] [geom_center $a(768)] [geom_center $a(777)] [geom_center $a(780)] ] 
	set zeta32 [dihedral  [geom_center $a(798)] [geom_center $a(800)] [geom_center $a(809)] [geom_center $a(812)] ] 
	set zeta33 [dihedral  [geom_center $a(830)] [geom_center $a(832)] [geom_center $a(841)] [geom_center $a(844)] ] 
	set zeta34 [dihedral  [geom_center $a(862)] [geom_center $a(864)] [geom_center $a(873)] [geom_center $a(876)] ] 
	set zeta35 [dihedral  [geom_center $a(894)] [geom_center $a(896)] [geom_center $a(905)] [geom_center $a(908)] ] 
	set zeta36 [dihedral  [geom_center $a(926)] [geom_center $a(928)] [geom_center $a(937)] [geom_center $a(940)] ] 
	set zeta37 [dihedral  [geom_center $a(958)] [geom_center $a(960)] [geom_center $a(969)] [geom_center $a(972)] ] 
	set zeta38 [dihedral  [geom_center $a(990)] [geom_center $a(992)] [geom_center $a(1005)] [geom_center $a(1008)] ] 

	set zeta40 [dihedral  [geom_center $a(1076)] [geom_center $a(1078)] [geom_center $a(1087)] [geom_center $a(1090)] ] 
	set zeta41 [dihedral  [geom_center $a(1108)] [geom_center $a(1110)] [geom_center $a(1119)] [geom_center $a(1122)] ] 
	set zeta42 [dihedral  [geom_center $a(1140)] [geom_center $a(1142)] [geom_center $a(1151)] [geom_center $a(1154)] ] 
	set zeta43 [dihedral  [geom_center $a(1172)] [geom_center $a(1174)] [geom_center $a(1183)] [geom_center $a(1186)] ] 
	set zeta44 [dihedral  [geom_center $a(1204)] [geom_center $a(1206)] [geom_center $a(1215)] [geom_center $a(1218)] ] 
	set zeta45 [dihedral  [geom_center $a(1236)] [geom_center $a(1238)] [geom_center $a(1247)] [geom_center $a(1250)] ] 
	set zeta46 [dihedral  [geom_center $a(1268)] [geom_center $a(1270)] [geom_center $a(1279)] [geom_center $a(1282)] ] 
	set zeta47 [dihedral  [geom_center $a(1300)] [geom_center $a(1302)] [geom_center $a(1311)] [geom_center $a(1314)] ] 
	set zeta48 [dihedral  [geom_center $a(1332)] [geom_center $a(1334)] [geom_center $a(1347)] [geom_center $a(1350)] ] 

	puts $fileId3 $zeta10
	puts $fileId3 $zeta11
	puts $fileId3 $zeta12
	puts $fileId3 $zeta13
	puts $fileId3 $zeta14
	puts $fileId3 $zeta15
	puts $fileId3 $zeta16
	puts $fileId3 $zeta17
	puts $fileId3 $zeta18

	puts $fileId3 $zeta20
	puts $fileId3 $zeta21
	puts $fileId3 $zeta22
	puts $fileId3 $zeta23
	puts $fileId3 $zeta24
	puts $fileId3 $zeta25
	puts $fileId3 $zeta26
	puts $fileId3 $zeta27
	puts $fileId3 $zeta28

	puts $fileId3 $zeta30
	puts $fileId3 $zeta31
	puts $fileId3 $zeta32
	puts $fileId3 $zeta33
	puts $fileId3 $zeta34
	puts $fileId3 $zeta35
	puts $fileId3 $zeta36
	puts $fileId3 $zeta37
	puts $fileId3 $zeta38

	puts $fileId3 $zeta40
	puts $fileId3 $zeta41
	puts $fileId3 $zeta42
	puts $fileId3 $zeta43
	puts $fileId3 $zeta44
	puts $fileId3 $zeta45
	puts $fileId3 $zeta46
	puts $fileId3 $zeta47
	puts $fileId3 $zeta48
}
close $fileId3
