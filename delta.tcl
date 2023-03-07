#!/usr/bin/tclsh

set num_steps [molinfo top get numframes]
set deltadata { 33 0 50 52\
 65 53 82 84\
 97 85 114 116\
 129 117 146 148\
 161 149 178 180\
 193 181 210 212\
 225 213 242 244\
 257 245 274 276\
 289 277 306 308\
 325 309 317 319\
 375 342 392 394\
 407 395 424 426\
 439 427 456 458\
 471 459 488 490\
 503 491 520 522\
 535 523 552 554\
 567 555 584 586\
 599 587 616 618\
 631 619 648 650\
 667 651 659 661\
 717 684 734 736\
 749 737 766 768\
 781 769 798 800\
 813 801 830 832\
 845 833 862 864\
 877 865 894 896\
 909 897 926 928\
 941 929 958 960\
 973 961 990 992\
 1009 993 1001 1003\
 1059 1026 1076 1078\
 1091 1079 1108 1110\
 1123 1111 1140 1142\
 1155 1143 1172 1174\
 1187 1175 1204 1206\
 1219 1207 1236 1238\
 1251 1239 1268 1270\
 1283 1271 1300 1302\
 1315 1303 1332 1334\
 1351 1335 1343 1345}

foreach i $deltadata {
	set a($i) [atomselect top "index $i"]
}

set fileId3 [open deltatest.dat w]

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

	foreach i $deltadata {
		$a($i) frame $frame
	}

	set delta10 [dihedral  [geom_center $a(33)] [geom_center $a(0)] [geom_center $a(50)] [geom_center $a(52)] ] 
	set delta11 [dihedral  [geom_center $a(65)] [geom_center $a(53)] [geom_center $a(82)] [geom_center $a(84)] ] 
	set delta12 [dihedral  [geom_center $a(97)] [geom_center $a(85)] [geom_center $a(114)] [geom_center $a(116)] ] 
	set delta13 [dihedral  [geom_center $a(129)] [geom_center $a(117)] [geom_center $a(146)] [geom_center $a(148)] ] 
	set delta14 [dihedral  [geom_center $a(161)] [geom_center $a(149)] [geom_center $a(178)] [geom_center $a(180)] ] 
	set delta15 [dihedral  [geom_center $a(193)] [geom_center $a(181)] [geom_center $a(210)] [geom_center $a(212)] ] 
	set delta16 [dihedral  [geom_center $a(225)] [geom_center $a(213)] [geom_center $a(242)] [geom_center $a(244)] ] 
	set delta17 [dihedral  [geom_center $a(257)] [geom_center $a(245)] [geom_center $a(274)] [geom_center $a(276)] ] 
	set delta18 [dihedral  [geom_center $a(289)] [geom_center $a(277)] [geom_center $a(306)] [geom_center $a(308)] ] 
	set delta19 [dihedral  [geom_center $a(325)] [geom_center $a(309)] [geom_center $a(317)] [geom_center $a(319)] ] 

	set delta20 [dihedral  [geom_center $a(375)] [geom_center $a(342)] [geom_center $a(392)] [geom_center $a(394)] ] 
	set delta21 [dihedral  [geom_center $a(407)] [geom_center $a(395)] [geom_center $a(424)] [geom_center $a(426)] ] 
	set delta22 [dihedral  [geom_center $a(439)] [geom_center $a(427)] [geom_center $a(456)] [geom_center $a(458)] ] 
	set delta23 [dihedral  [geom_center $a(471)] [geom_center $a(459)] [geom_center $a(488)] [geom_center $a(490)] ] 
	set delta24 [dihedral  [geom_center $a(503)] [geom_center $a(491)] [geom_center $a(520)] [geom_center $a(522)] ] 
	set delta25 [dihedral  [geom_center $a(535)] [geom_center $a(523)] [geom_center $a(552)] [geom_center $a(554)] ] 
	set delta26 [dihedral  [geom_center $a(567)] [geom_center $a(555)] [geom_center $a(584)] [geom_center $a(586)] ] 
	set delta27 [dihedral  [geom_center $a(599)] [geom_center $a(587)] [geom_center $a(616)] [geom_center $a(618)] ] 
	set delta28 [dihedral  [geom_center $a(631)] [geom_center $a(619)] [geom_center $a(648)] [geom_center $a(650)] ] 
	set delta29 [dihedral  [geom_center $a(667)] [geom_center $a(651)] [geom_center $a(659)] [geom_center $a(661)] ] 

	set delta30 [dihedral  [geom_center $a(717)] [geom_center $a(684)] [geom_center $a(734)] [geom_center $a(736)] ] 
	set delta31 [dihedral  [geom_center $a(749)] [geom_center $a(737)] [geom_center $a(766)] [geom_center $a(768)] ] 
	set delta32 [dihedral  [geom_center $a(781)] [geom_center $a(769)] [geom_center $a(798)] [geom_center $a(800)] ] 
	set delta33 [dihedral  [geom_center $a(813)] [geom_center $a(801)] [geom_center $a(830)] [geom_center $a(832)] ] 
	set delta34 [dihedral  [geom_center $a(845)] [geom_center $a(833)] [geom_center $a(862)] [geom_center $a(864)] ] 
	set delta35 [dihedral  [geom_center $a(877)] [geom_center $a(865)] [geom_center $a(894)] [geom_center $a(896)] ] 
	set delta36 [dihedral  [geom_center $a(909)] [geom_center $a(897)] [geom_center $a(926)] [geom_center $a(928)] ] 
	set delta37 [dihedral  [geom_center $a(941)] [geom_center $a(929)] [geom_center $a(958)] [geom_center $a(960)] ] 
	set delta38 [dihedral  [geom_center $a(973)] [geom_center $a(961)] [geom_center $a(990)] [geom_center $a(992)] ] 
	set delta39 [dihedral  [geom_center $a(1009)] [geom_center $a(993)] [geom_center $a(1001)] [geom_center $a(1003)] ] 

	set delta40 [dihedral  [geom_center $a(1059)] [geom_center $a(1026)] [geom_center $a(1076)] [geom_center $a(1078)] ] 
	set delta41 [dihedral  [geom_center $a(1091)] [geom_center $a(1079)] [geom_center $a(1108)] [geom_center $a(1110)] ] 
	set delta42 [dihedral  [geom_center $a(1123)] [geom_center $a(1111)] [geom_center $a(1140)] [geom_center $a(1142)] ] 
	set delta43 [dihedral  [geom_center $a(1155)] [geom_center $a(1143)] [geom_center $a(1172)] [geom_center $a(1174)] ] 
	set delta44 [dihedral  [geom_center $a(1187)] [geom_center $a(1175)] [geom_center $a(1204)] [geom_center $a(1206)] ] 
	set delta45 [dihedral  [geom_center $a(1219)] [geom_center $a(1207)] [geom_center $a(1236)] [geom_center $a(1238)] ] 
	set delta46 [dihedral  [geom_center $a(1251)] [geom_center $a(1239)] [geom_center $a(1268)] [geom_center $a(1270)] ] 
	set delta47 [dihedral  [geom_center $a(1283)] [geom_center $a(1271)] [geom_center $a(1300)] [geom_center $a(1302)] ] 
	set delta48 [dihedral  [geom_center $a(1315)] [geom_center $a(1303)] [geom_center $a(1332)] [geom_center $a(1334)] ] 
	set delta49 [dihedral  [geom_center $a(1351)] [geom_center $a(1335)] [geom_center $a(1343)] [geom_center $a(1345)] ] 

	puts $fileId3 $delta10
	puts $fileId3 $delta11
	puts $fileId3 $delta12
	puts $fileId3 $delta13
	puts $fileId3 $delta14
	puts $fileId3 $delta15
	puts $fileId3 $delta16
	puts $fileId3 $delta17
	puts $fileId3 $delta18
	puts $fileId3 $delta19

	puts $fileId3 $delta20
	puts $fileId3 $delta21
	puts $fileId3 $delta22
	puts $fileId3 $delta23
	puts $fileId3 $delta24
	puts $fileId3 $delta25
	puts $fileId3 $delta26
	puts $fileId3 $delta27
	puts $fileId3 $delta28
	puts $fileId3 $delta29

	puts $fileId3 $delta30
	puts $fileId3 $delta31
	puts $fileId3 $delta32
	puts $fileId3 $delta33
	puts $fileId3 $delta34
	puts $fileId3 $delta35
	puts $fileId3 $delta36
	puts $fileId3 $delta37
	puts $fileId3 $delta38
	puts $fileId3 $delta39

	puts $fileId3 $delta40
	puts $fileId3 $delta41
	puts $fileId3 $delta42
	puts $fileId3 $delta43
	puts $fileId3 $delta44
	puts $fileId3 $delta45
	puts $fileId3 $delta46
	puts $fileId3 $delta47
	puts $fileId3 $delta48
	puts $fileId3 $delta49

}
close $fileId3
