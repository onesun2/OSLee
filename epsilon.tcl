#!/usr/bin/tclsh

set num_steps [molinfo top get numframes]
set epsilondata { 0 50 52 61\
 53 82 84 93\
 85 114 116 125\
 117 146 148 157\
 149 178 180 189\
 181 210 212 221\
 213 242 244 253\
 245 274 276 285\
 277 306 308 321\
 342 392 394 403\
 395 424 426 435\
 427 456 458 467\
 459 488 490 499\
 491 520 522 531\
 523 552 554 563\
 555 584 586 595\
 587 616 618 627\
 619 648 650 663\
 684 734 736 745\
 737 766 768 777\
 769 798 800 809\
 801 830 832 841\
 833 862 864 873\
 865 894 896 905\
 897 926 928 937\
 929 958 960 969\
 961 990 992 1005\
 1026 1076 1078 1087\
 1079 1108 1110 1119\
 1111 1140 1142 1151\
 1143 1172 1174 1183\
 1175 1204 1206 1215\
 1207 1236 1238 1247\
 1239 1268 1270 1279\
 1271 1300 1302 1311\
 1303 1332 1334 1347}

foreach i $epsilondata {
	set a($i) [atomselect top "index $i"]
}

set fileId3 [open epsilontest.dat w]

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

	foreach i $epsilondata {
		$a($i) frame $frame
	}

	set epsilon10 [dihedral  [geom_center $a(0)] [geom_center $a(50)] [geom_center $a(52)] [geom_center $a(61)] ] 
	set epsilon11 [dihedral  [geom_center $a(53)] [geom_center $a(82)] [geom_center $a(84)] [geom_center $a(93)] ] 
	set epsilon12 [dihedral  [geom_center $a(85)] [geom_center $a(114)] [geom_center $a(116)] [geom_center $a(125)] ] 
	set epsilon13 [dihedral  [geom_center $a(117)] [geom_center $a(146)] [geom_center $a(148)] [geom_center $a(157)] ] 
	set epsilon14 [dihedral  [geom_center $a(149)] [geom_center $a(178)] [geom_center $a(180)] [geom_center $a(189)] ] 
	set epsilon15 [dihedral  [geom_center $a(181)] [geom_center $a(210)] [geom_center $a(212)] [geom_center $a(221)] ] 
	set epsilon16 [dihedral  [geom_center $a(213)] [geom_center $a(242)] [geom_center $a(244)] [geom_center $a(253)] ] 
	set epsilon17 [dihedral  [geom_center $a(245)] [geom_center $a(274)] [geom_center $a(276)] [geom_center $a(285)] ] 
	set epsilon18 [dihedral  [geom_center $a(277)] [geom_center $a(306)] [geom_center $a(308)] [geom_center $a(321)] ] 

	set epsilon20 [dihedral  [geom_center $a(342)] [geom_center $a(392)] [geom_center $a(394)] [geom_center $a(403)] ] 
	set epsilon21 [dihedral  [geom_center $a(395)] [geom_center $a(424)] [geom_center $a(426)] [geom_center $a(435)] ] 
	set epsilon22 [dihedral  [geom_center $a(427)] [geom_center $a(456)] [geom_center $a(458)] [geom_center $a(467)] ] 
	set epsilon23 [dihedral  [geom_center $a(459)] [geom_center $a(488)] [geom_center $a(490)] [geom_center $a(499)] ] 
	set epsilon24 [dihedral  [geom_center $a(491)] [geom_center $a(520)] [geom_center $a(522)] [geom_center $a(531)] ] 
	set epsilon25 [dihedral  [geom_center $a(523)] [geom_center $a(552)] [geom_center $a(554)] [geom_center $a(563)] ] 
	set epsilon26 [dihedral  [geom_center $a(555)] [geom_center $a(584)] [geom_center $a(586)] [geom_center $a(595)] ] 
	set epsilon27 [dihedral  [geom_center $a(587)] [geom_center $a(616)] [geom_center $a(618)] [geom_center $a(627)] ] 
	set epsilon28 [dihedral  [geom_center $a(619)] [geom_center $a(648)] [geom_center $a(650)] [geom_center $a(663)] ] 

	set epsilon30 [dihedral  [geom_center $a(684)] [geom_center $a(734)] [geom_center $a(736)] [geom_center $a(745)] ] 
	set epsilon31 [dihedral  [geom_center $a(737)] [geom_center $a(766)] [geom_center $a(768)] [geom_center $a(777)] ] 
	set epsilon32 [dihedral  [geom_center $a(769)] [geom_center $a(798)] [geom_center $a(800)] [geom_center $a(809)] ] 
	set epsilon33 [dihedral  [geom_center $a(801)] [geom_center $a(830)] [geom_center $a(832)] [geom_center $a(841)] ] 
	set epsilon34 [dihedral  [geom_center $a(833)] [geom_center $a(862)] [geom_center $a(864)] [geom_center $a(873)] ] 
	set epsilon35 [dihedral  [geom_center $a(865)] [geom_center $a(894)] [geom_center $a(896)] [geom_center $a(905)] ] 
	set epsilon36 [dihedral  [geom_center $a(897)] [geom_center $a(926)] [geom_center $a(928)] [geom_center $a(937)] ] 
	set epsilon37 [dihedral  [geom_center $a(929)] [geom_center $a(958)] [geom_center $a(960)] [geom_center $a(969)] ] 
	set epsilon38 [dihedral  [geom_center $a(961)] [geom_center $a(990)] [geom_center $a(992)] [geom_center $a(1005)] ] 

	set epsilon40 [dihedral  [geom_center $a(1026)] [geom_center $a(1076)] [geom_center $a(1078)] [geom_center $a(1087)] ] 
	set epsilon41 [dihedral  [geom_center $a(1079)] [geom_center $a(1108)] [geom_center $a(1110)] [geom_center $a(1119)] ] 
	set epsilon42 [dihedral  [geom_center $a(1111)] [geom_center $a(1140)] [geom_center $a(1142)] [geom_center $a(1151)] ] 
	set epsilon43 [dihedral  [geom_center $a(1143)] [geom_center $a(1172)] [geom_center $a(1174)] [geom_center $a(1183)] ] 
	set epsilon44 [dihedral  [geom_center $a(1175)] [geom_center $a(1204)] [geom_center $a(1206)] [geom_center $a(1215)] ] 
	set epsilon45 [dihedral  [geom_center $a(1207)] [geom_center $a(1236)] [geom_center $a(1238)] [geom_center $a(1247)] ] 
	set epsilon46 [dihedral  [geom_center $a(1239)] [geom_center $a(1268)] [geom_center $a(1270)] [geom_center $a(1279)] ] 
	set epsilon47 [dihedral  [geom_center $a(1271)] [geom_center $a(1300)] [geom_center $a(1302)] [geom_center $a(1311)] ] 
	set epsilon48 [dihedral  [geom_center $a(1303)] [geom_center $a(1332)] [geom_center $a(1334)] [geom_center $a(1347)] ] 

	puts $fileId3 $epsilon10
	puts $fileId3 $epsilon11
	puts $fileId3 $epsilon12
	puts $fileId3 $epsilon13
	puts $fileId3 $epsilon14
	puts $fileId3 $epsilon15
	puts $fileId3 $epsilon16
	puts $fileId3 $epsilon17
	puts $fileId3 $epsilon18

	puts $fileId3 $epsilon20
	puts $fileId3 $epsilon21
	puts $fileId3 $epsilon22
	puts $fileId3 $epsilon23
	puts $fileId3 $epsilon24
	puts $fileId3 $epsilon25
	puts $fileId3 $epsilon26
	puts $fileId3 $epsilon27
	puts $fileId3 $epsilon28

	puts $fileId3 $epsilon30
	puts $fileId3 $epsilon31
	puts $fileId3 $epsilon32
	puts $fileId3 $epsilon33
	puts $fileId3 $epsilon34
	puts $fileId3 $epsilon35
	puts $fileId3 $epsilon36
	puts $fileId3 $epsilon37
	puts $fileId3 $epsilon38

	puts $fileId3 $epsilon40
	puts $fileId3 $epsilon41
	puts $fileId3 $epsilon42
	puts $fileId3 $epsilon43
	puts $fileId3 $epsilon44
	puts $fileId3 $epsilon45
	puts $fileId3 $epsilon46
	puts $fileId3 $epsilon47
	puts $fileId3 $epsilon48
}
close $fileId3
