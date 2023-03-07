#!/usr/bin/tclsh

set num_steps [molinfo top get numframes]
set gammadata { 32 33 0 50\
 64 65 53 82\
 96 97 85 114\
 128 129 117 146\
 160 161 149 178\
 192 193 181 210\
 224 225 213 242\
 256 257 245 274\
 288 289 277 306\
 324 325 309 317\
 374 375 342 392\
 406 407 395 424\
 438 439 427 456\
 470 471 459 488\
 502 503 491 520\
 534 535 523 552\
 566 567 555 584\
 598 599 587 616\
 630 631 619 648\
 666 667 651 659\
 716 717 684 734\
 748 749 737 766\
 780 781 769 798\
 812 813 801 830\
 844 845 833 862\
 876 877 865 894\
 908 909 897 926\
 940 941 929 958\
 972 973 961 990\
 1008 1009 993 1001\
 1058 1059 1026 1076\
 1090 1091 1079 1108\
 1122 1123 1111 1140\
 1154 1155 1143 1172\
 1186 1187 1175 1204\
 1218 1219 1207 1236\
 1250 1251 1239 1268\
 1282 1283 1271 1300\
 1314 1315 1303 1332\
 1350 1351 1335 1343}

foreach i $gammadata {
	set a($i) [atomselect top "index $i"]
}

set fileId3 [open gammatest.dat w]

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

	foreach i $gammadata {
		$a($i) frame $frame
	}

	set gamma10 [dihedral  [geom_center $a(32)] [geom_center $a(33)] [geom_center $a(0)] [geom_center $a(50)] ] 
	set gamma11 [dihedral  [geom_center $a(64)] [geom_center $a(65)] [geom_center $a(53)] [geom_center $a(82)] ] 
	set gamma12 [dihedral  [geom_center $a(96)] [geom_center $a(97)] [geom_center $a(85)] [geom_center $a(114)] ] 
	set gamma13 [dihedral  [geom_center $a(128)] [geom_center $a(129)] [geom_center $a(117)] [geom_center $a(146)] ] 
	set gamma14 [dihedral  [geom_center $a(160)] [geom_center $a(161)] [geom_center $a(149)] [geom_center $a(178)] ] 
	set gamma15 [dihedral  [geom_center $a(192)] [geom_center $a(193)] [geom_center $a(181)] [geom_center $a(210)] ] 
	set gamma16 [dihedral  [geom_center $a(224)] [geom_center $a(225)] [geom_center $a(213)] [geom_center $a(242)] ] 
	set gamma17 [dihedral  [geom_center $a(256)] [geom_center $a(257)] [geom_center $a(245)] [geom_center $a(274)] ] 
	set gamma18 [dihedral  [geom_center $a(288)] [geom_center $a(289)] [geom_center $a(277)] [geom_center $a(306)] ] 
	set gamma19 [dihedral  [geom_center $a(324)] [geom_center $a(325)] [geom_center $a(309)] [geom_center $a(317)] ] 

	set gamma20 [dihedral  [geom_center $a(374)] [geom_center $a(375)] [geom_center $a(342)] [geom_center $a(392)] ] 
	set gamma21 [dihedral  [geom_center $a(406)] [geom_center $a(407)] [geom_center $a(395)] [geom_center $a(424)] ] 
	set gamma22 [dihedral  [geom_center $a(438)] [geom_center $a(439)] [geom_center $a(427)] [geom_center $a(456)] ] 
	set gamma23 [dihedral  [geom_center $a(470)] [geom_center $a(471)] [geom_center $a(459)] [geom_center $a(488)] ] 
	set gamma24 [dihedral  [geom_center $a(502)] [geom_center $a(503)] [geom_center $a(491)] [geom_center $a(520)] ] 
	set gamma25 [dihedral  [geom_center $a(534)] [geom_center $a(535)] [geom_center $a(523)] [geom_center $a(552)] ] 
	set gamma26 [dihedral  [geom_center $a(566)] [geom_center $a(567)] [geom_center $a(555)] [geom_center $a(584)] ] 
	set gamma27 [dihedral  [geom_center $a(598)] [geom_center $a(599)] [geom_center $a(587)] [geom_center $a(616)] ] 
	set gamma28 [dihedral  [geom_center $a(630)] [geom_center $a(631)] [geom_center $a(619)] [geom_center $a(648)] ] 
	set gamma29 [dihedral  [geom_center $a(666)] [geom_center $a(667)] [geom_center $a(651)] [geom_center $a(659)] ] 

	set gamma30 [dihedral  [geom_center $a(716)] [geom_center $a(717)] [geom_center $a(684)] [geom_center $a(734)] ] 
	set gamma31 [dihedral  [geom_center $a(748)] [geom_center $a(749)] [geom_center $a(737)] [geom_center $a(766)] ] 
	set gamma32 [dihedral  [geom_center $a(780)] [geom_center $a(781)] [geom_center $a(769)] [geom_center $a(798)] ] 
	set gamma33 [dihedral  [geom_center $a(812)] [geom_center $a(813)] [geom_center $a(801)] [geom_center $a(830)] ] 
	set gamma34 [dihedral  [geom_center $a(844)] [geom_center $a(845)] [geom_center $a(833)] [geom_center $a(862)] ] 
	set gamma35 [dihedral  [geom_center $a(876)] [geom_center $a(877)] [geom_center $a(865)] [geom_center $a(894)] ] 
	set gamma36 [dihedral  [geom_center $a(908)] [geom_center $a(909)] [geom_center $a(897)] [geom_center $a(926)] ] 
	set gamma37 [dihedral  [geom_center $a(940)] [geom_center $a(941)] [geom_center $a(929)] [geom_center $a(958)] ] 
	set gamma38 [dihedral  [geom_center $a(972)] [geom_center $a(973)] [geom_center $a(961)] [geom_center $a(990)] ] 
	set gamma39 [dihedral  [geom_center $a(1008)] [geom_center $a(1009)] [geom_center $a(993)] [geom_center $a(1001)] ] 

	set gamma40 [dihedral  [geom_center $a(1058)] [geom_center $a(1059)] [geom_center $a(1026)] [geom_center $a(1076)] ] 
	set gamma41 [dihedral  [geom_center $a(1090)] [geom_center $a(1091)] [geom_center $a(1079)] [geom_center $a(1108)] ] 
	set gamma42 [dihedral  [geom_center $a(1122)] [geom_center $a(1123)] [geom_center $a(1111)] [geom_center $a(1140)] ] 
	set gamma43 [dihedral  [geom_center $a(1154)] [geom_center $a(1155)] [geom_center $a(1143)] [geom_center $a(1172)] ] 
	set gamma44 [dihedral  [geom_center $a(1186)] [geom_center $a(1187)] [geom_center $a(1175)] [geom_center $a(1204)] ] 
	set gamma45 [dihedral  [geom_center $a(1218)] [geom_center $a(1219)] [geom_center $a(1207)] [geom_center $a(1236)] ] 
	set gamma46 [dihedral  [geom_center $a(1250)] [geom_center $a(1251)] [geom_center $a(1239)] [geom_center $a(1268)] ] 
	set gamma47 [dihedral  [geom_center $a(1282)] [geom_center $a(1283)] [geom_center $a(1271)] [geom_center $a(1300)] ] 
	set gamma48 [dihedral  [geom_center $a(1314)] [geom_center $a(1315)] [geom_center $a(1303)] [geom_center $a(1332)] ] 
	set gamma49 [dihedral  [geom_center $a(1350)] [geom_center $a(1351)] [geom_center $a(1335)] [geom_center $a(1343)] ] 

	puts $fileId3 $gamma10
	puts $fileId3 $gamma11
	puts $fileId3 $gamma12
	puts $fileId3 $gamma13
	puts $fileId3 $gamma14
	puts $fileId3 $gamma15
	puts $fileId3 $gamma16
	puts $fileId3 $gamma17
	puts $fileId3 $gamma18
	puts $fileId3 $gamma19

	puts $fileId3 $gamma20
	puts $fileId3 $gamma21
	puts $fileId3 $gamma22
	puts $fileId3 $gamma23
	puts $fileId3 $gamma24
	puts $fileId3 $gamma25
	puts $fileId3 $gamma26
	puts $fileId3 $gamma27
	puts $fileId3 $gamma28
	puts $fileId3 $gamma29

	puts $fileId3 $gamma30
	puts $fileId3 $gamma31
	puts $fileId3 $gamma32
	puts $fileId3 $gamma33
	puts $fileId3 $gamma34
	puts $fileId3 $gamma35
	puts $fileId3 $gamma36
	puts $fileId3 $gamma37
	puts $fileId3 $gamma38
	puts $fileId3 $gamma39

	puts $fileId3 $gamma40
	puts $fileId3 $gamma41
	puts $fileId3 $gamma42
	puts $fileId3 $gamma43
	puts $fileId3 $gamma44
	puts $fileId3 $gamma45
	puts $fileId3 $gamma46
	puts $fileId3 $gamma47
	puts $fileId3 $gamma48
	puts $fileId3 $gamma49

}
close $fileId3
