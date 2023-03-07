#!/usr/bin/tclsh

set num_steps [molinfo top get numframes]
set betadata { 29 32 33 0\
 61 64 65 53\
 93 96 97 85\
 125 128 129 117\
 157 160 161 149\
 189 192 193 181\
 221 224 225 213\
 253 256 257 245\
 285 288 289 277\
 321 324 325 309\
 371 374 375 342\
 403 406 407 395\
 435 438 439 427\
 467 470 471 459\
 499 502 503 491\
 531 534 535 523\
 563 566 567 555\
 595 598 599 587\
 627 630 631 619\
 663 666 667 651\
 713 716 717 684\
 745 748 749 737\
 777 780 781 769\
 809 812 813 801\
 841 844 845 833\
 873 876 877 865\
 905 908 909 897\
 937 940 941 929\
 969 972 973 961\
 1005 1008 1009 993\
 1055 1058 1059 1026\
 1087 1090 1091 1079\
 1119 1122 1123 1111\
 1151 1154 1155 1143\
 1183 1186 1187 1175\
 1215 1218 1219 1207\
 1247 1250 1251 1239\
 1279 1282 1283 1271\
 1311 1314 1315 1303\
 1347 1350 1351 1335}

foreach i $betadata {
	set a($i) [atomselect top "index $i"]
}

set fileId3 [open betatest.dat w]

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

	foreach i $betadata {
		$a($i) frame $frame
	}

	set beta10 [dihedral  [geom_center $a(29)] [geom_center $a(32)] [geom_center $a(33)] [geom_center $a(0)] ] 
	set beta11 [dihedral  [geom_center $a(61)] [geom_center $a(64)] [geom_center $a(65)] [geom_center $a(53)] ] 
	set beta12 [dihedral  [geom_center $a(93)] [geom_center $a(96)] [geom_center $a(97)] [geom_center $a(85)] ] 
	set beta13 [dihedral  [geom_center $a(125)] [geom_center $a(128)] [geom_center $a(129)] [geom_center $a(117)] ] 
	set beta14 [dihedral  [geom_center $a(157)] [geom_center $a(160)] [geom_center $a(161)] [geom_center $a(149)] ] 
	set beta15 [dihedral  [geom_center $a(189)] [geom_center $a(192)] [geom_center $a(193)] [geom_center $a(181)] ] 
	set beta16 [dihedral  [geom_center $a(221)] [geom_center $a(224)] [geom_center $a(225)] [geom_center $a(213)] ] 
	set beta17 [dihedral  [geom_center $a(253)] [geom_center $a(256)] [geom_center $a(257)] [geom_center $a(245)] ] 
	set beta18 [dihedral  [geom_center $a(285)] [geom_center $a(288)] [geom_center $a(289)] [geom_center $a(277)] ] 
	set beta19 [dihedral  [geom_center $a(321)] [geom_center $a(324)] [geom_center $a(325)] [geom_center $a(309)] ] 

	set beta20 [dihedral  [geom_center $a(371)] [geom_center $a(374)] [geom_center $a(375)] [geom_center $a(342)] ] 
	set beta21 [dihedral  [geom_center $a(403)] [geom_center $a(406)] [geom_center $a(407)] [geom_center $a(395)] ] 
	set beta22 [dihedral  [geom_center $a(435)] [geom_center $a(438)] [geom_center $a(439)] [geom_center $a(427)] ] 
	set beta23 [dihedral  [geom_center $a(467)] [geom_center $a(470)] [geom_center $a(471)] [geom_center $a(459)] ] 
	set beta24 [dihedral  [geom_center $a(499)] [geom_center $a(502)] [geom_center $a(503)] [geom_center $a(491)] ] 
	set beta25 [dihedral  [geom_center $a(531)] [geom_center $a(534)] [geom_center $a(535)] [geom_center $a(523)] ] 
	set beta26 [dihedral  [geom_center $a(563)] [geom_center $a(566)] [geom_center $a(567)] [geom_center $a(555)] ] 
	set beta27 [dihedral  [geom_center $a(595)] [geom_center $a(598)] [geom_center $a(599)] [geom_center $a(587)] ] 
	set beta28 [dihedral  [geom_center $a(627)] [geom_center $a(630)] [geom_center $a(631)] [geom_center $a(619)] ] 
	set beta29 [dihedral  [geom_center $a(663)] [geom_center $a(666)] [geom_center $a(667)] [geom_center $a(651)] ] 

	set beta30 [dihedral  [geom_center $a(713)] [geom_center $a(716)] [geom_center $a(717)] [geom_center $a(684)] ] 
	set beta31 [dihedral  [geom_center $a(745)] [geom_center $a(748)] [geom_center $a(749)] [geom_center $a(737)] ] 
	set beta32 [dihedral  [geom_center $a(777)] [geom_center $a(780)] [geom_center $a(781)] [geom_center $a(769)] ] 
	set beta33 [dihedral  [geom_center $a(809)] [geom_center $a(812)] [geom_center $a(813)] [geom_center $a(801)] ] 
	set beta34 [dihedral  [geom_center $a(841)] [geom_center $a(844)] [geom_center $a(845)] [geom_center $a(833)] ] 
	set beta35 [dihedral  [geom_center $a(873)] [geom_center $a(876)] [geom_center $a(877)] [geom_center $a(865)] ] 
	set beta36 [dihedral  [geom_center $a(905)] [geom_center $a(908)] [geom_center $a(909)] [geom_center $a(897)] ] 
	set beta37 [dihedral  [geom_center $a(937)] [geom_center $a(940)] [geom_center $a(941)] [geom_center $a(929)] ] 
	set beta38 [dihedral  [geom_center $a(969)] [geom_center $a(972)] [geom_center $a(973)] [geom_center $a(961)] ] 
	set beta39 [dihedral  [geom_center $a(1005)] [geom_center $a(1008)] [geom_center $a(1009)] [geom_center $a(993)] ] 

	set beta40 [dihedral  [geom_center $a(1055)] [geom_center $a(1058)] [geom_center $a(1059)] [geom_center $a(1026)] ] 
	set beta41 [dihedral  [geom_center $a(1087)] [geom_center $a(1090)] [geom_center $a(1091)] [geom_center $a(1079)] ] 
	set beta42 [dihedral  [geom_center $a(1119)] [geom_center $a(1122)] [geom_center $a(1123)] [geom_center $a(1111)] ] 
	set beta43 [dihedral  [geom_center $a(1151)] [geom_center $a(1154)] [geom_center $a(1155)] [geom_center $a(1143)] ] 
	set beta44 [dihedral  [geom_center $a(1183)] [geom_center $a(1186)] [geom_center $a(1187)] [geom_center $a(1175)] ] 
	set beta45 [dihedral  [geom_center $a(1215)] [geom_center $a(1218)] [geom_center $a(1219)] [geom_center $a(1207)] ] 
	set beta46 [dihedral  [geom_center $a(1247)] [geom_center $a(1250)] [geom_center $a(1251)] [geom_center $a(1239)] ] 
	set beta47 [dihedral  [geom_center $a(1279)] [geom_center $a(1282)] [geom_center $a(1283)] [geom_center $a(1271)] ] 
	set beta48 [dihedral  [geom_center $a(1311)] [geom_center $a(1314)] [geom_center $a(1315)] [geom_center $a(1303)] ] 
	set beta49 [dihedral  [geom_center $a(1347)] [geom_center $a(1350)] [geom_center $a(1351)] [geom_center $a(1335)] ] 

	puts $fileId3 $beta10
	puts $fileId3 $beta11
	puts $fileId3 $beta12
	puts $fileId3 $beta13
	puts $fileId3 $beta14
	puts $fileId3 $beta15
	puts $fileId3 $beta16
	puts $fileId3 $beta17
	puts $fileId3 $beta18
	puts $fileId3 $beta19

	puts $fileId3 $beta20
	puts $fileId3 $beta21
	puts $fileId3 $beta22
	puts $fileId3 $beta23
	puts $fileId3 $beta24
	puts $fileId3 $beta25
	puts $fileId3 $beta26
	puts $fileId3 $beta27
	puts $fileId3 $beta28
	puts $fileId3 $beta29

	puts $fileId3 $beta30
	puts $fileId3 $beta31
	puts $fileId3 $beta32
	puts $fileId3 $beta33
	puts $fileId3 $beta34
	puts $fileId3 $beta35
	puts $fileId3 $beta36
	puts $fileId3 $beta37
	puts $fileId3 $beta38
	puts $fileId3 $beta39

	puts $fileId3 $beta40
	puts $fileId3 $beta41
	puts $fileId3 $beta42
	puts $fileId3 $beta43
	puts $fileId3 $beta44
	puts $fileId3 $beta45
	puts $fileId3 $beta46
	puts $fileId3 $beta47
	puts $fileId3 $beta48
	puts $fileId3 $beta49

}
close $fileId3
