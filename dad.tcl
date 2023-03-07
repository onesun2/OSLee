#!/usr/bin/tclsh

set num_steps [molinfo top get numframes]
set m00 [atomselect top "(name CA1 CA2 CA3 CA4 CA5 CA6) and (residue  0)"]
set m01 [atomselect top "(name CA1 CA2 CA3 CA4 CA5 CA6) and (residue  1)"]
set m02 [atomselect top "(name CA1 CA2 CA3 CA4 CA5 CA6) and (residue  2)"]
set m03 [atomselect top "(name CA1 CA2 CA3 CA4 CA5 CA6) and (residue  3)"]
set m04 [atomselect top "(name CA1 CA2 CA3 CA4 CA5 CA6) and (residue  4)"]
set m05 [atomselect top "(name CA1 CA2 CA3 CA4 CA5 CA6) and (residue  5)"]
set m06 [atomselect top "(name CA1 CA2 CA3 CA4 CA5 CA6) and (residue  6)"]
set m07 [atomselect top "(name CA1 CA2 CA3 CA4 CA5 CA6) and (residue  7)"]
set m08 [atomselect top "(name CA1 CA2 CA3 CA4 CA5 CA6) and (residue  8)"]
set m09 [atomselect top "(name CA1 CA2 CA3 CA4 CA5 CA6) and (residue  9)"]
set m10 [atomselect top "(name CA1 CA2 CA3 CA4 CA5 CA6) and (residue 10)"]
set m11 [atomselect top "(name CA1 CA2 CA3 CA4 CA5 CA6) and (residue 11)"]
set m12 [atomselect top "(name CA1 CA2 CA3 CA4 CA5 CA6) and (residue 12)"]
set m13 [atomselect top "(name CA1 CA2 CA3 CA4 CA5 CA6) and (residue 13)"]
set m14 [atomselect top "(name CA1 CA2 CA3 CA4 CA5 CA6) and (residue 14)"]
set m15 [atomselect top "(name CA1 CA2 CA3 CA4 CA5 CA6) and (residue 15)"]
set m16 [atomselect top "(name CA1 CA2 CA3 CA4 CA5 CA6) and (residue 16)"]
set m17 [atomselect top "(name CA1 CA2 CA3 CA4 CA5 CA6) and (residue 17)"]

set filename1 "mdis.txt"
set fileId1 [open $filename1 "a"]

set filename2 "mang.txt"
set fileId2 [open $filename2 "a"]

set filename3 "mdih.txt"
set fileId3 [open $filename3 "a"]

proc angle {a b c} {
	set v1 [vecsub $a $b]
	set v2 [vecsub $c $b]

	set ddd [vecdot $v1 $v2]
	set len [expr [veclength $v1]*[veclength $v2]]

	return [expr 57.2958*acos($ddd/$len)]
}

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

	$m00 frame $frame	
	$m01 frame $frame	
	$m02 frame $frame	
	$m03 frame $frame	
	$m04 frame $frame	
	$m05 frame $frame	
	$m06 frame $frame	
	$m07 frame $frame	
	$m08 frame $frame	
	$m09 frame $frame	
	$m10 frame $frame	
	$m11 frame $frame	
	$m12 frame $frame	
	$m13 frame $frame	
	$m14 frame $frame	
	$m15 frame $frame	
	$m16 frame $frame	
	$m17 frame $frame	

	set c00 [geom_center $m00]
	set c01 [geom_center $m01]
	set c02 [geom_center $m02]
	set c03 [geom_center $m03]
	set c04 [geom_center $m04]
	set c05 [geom_center $m05]
	set c06 [geom_center $m06]
	set c07 [geom_center $m07]
	set c08 [geom_center $m08]
	set c09 [geom_center $m09]
	set c10 [geom_center $m10]
	set c11 [geom_center $m11]
	set c12 [geom_center $m12]
	set c13 [geom_center $m13]
	set c14 [geom_center $m14]
	set c15 [geom_center $m15]
	set c16 [geom_center $m16]
	set c17 [geom_center $m17]

#	puts $fileId3 "frame = $frame"

	puts $fileId3 "[dihedral $c00 $c01 $c02 $c03] " nonewline
	puts $fileId3 "[dihedral $c01 $c02 $c03 $c04] " nonewline
	puts $fileId3 "[dihedral $c02 $c03 $c04 $c05] " nonewline
	puts $fileId3 "[dihedral $c03 $c04 $c05 $c06] " nonewline
	puts $fileId3 "[dihedral $c04 $c05 $c06 $c07] " nonewline
	puts $fileId3 "[dihedral $c05 $c06 $c07 $c08] " nonewline
	puts $fileId3 "[dihedral $c06 $c07 $c08 $c09] " nonewline
	puts $fileId3 "[dihedral $c07 $c08 $c09 $c10] " nonewline
	puts $fileId3 "[dihedral $c08 $c09 $c10 $c11] " nonewline
	puts $fileId3 "[dihedral $c09 $c10 $c11 $c12] " nonewline
	puts $fileId3 "[dihedral $c10 $c11 $c12 $c13] " nonewline
	puts $fileId3 "[dihedral $c11 $c12 $c13 $c14] " nonewline
	puts $fileId3 "[dihedral $c12 $c13 $c14 $c15] " nonewline
	puts $fileId3 "[dihedral $c13 $c14 $c15 $c16] " nonewline
	puts $fileId3 "[dihedral $c14 $c15 $c16 $c17]"

	puts $fileId1 "[vecdist $c00 $c01] " nonewline
	puts $fileId1 "[vecdist $c01 $c02] " nonewline
	puts $fileId1 "[vecdist $c02 $c03] " nonewline
	puts $fileId1 "[vecdist $c03 $c04] " nonewline
	puts $fileId1 "[vecdist $c04 $c05] " nonewline
	puts $fileId1 "[vecdist $c05 $c06] " nonewline
	puts $fileId1 "[vecdist $c06 $c07] " nonewline
	puts $fileId1 "[vecdist $c07 $c08] " nonewline
	puts $fileId1 "[vecdist $c08 $c09] " nonewline
	puts $fileId1 "[vecdist $c09 $c10] " nonewline
	puts $fileId1 "[vecdist $c10 $c11] " nonewline
	puts $fileId1 "[vecdist $c11 $c12] " nonewline
	puts $fileId1 "[vecdist $c12 $c13] " nonewline
	puts $fileId1 "[vecdist $c13 $c14] " nonewline
	puts $fileId1 "[vecdist $c14 $c15] " nonewline
	puts $fileId1 "[vecdist $c15 $c16] " nonewline
	puts $fileId1 "[vecdist $c16 $c17]"

	puts $fileId2 "[angle $c00 $c01 $c02] " nonewline
	puts $fileId2 "[angle $c01 $c02 $c03] " nonewline
	puts $fileId2 "[angle $c02 $c03 $c04] " nonewline
	puts $fileId2 "[angle $c03 $c04 $c05] " nonewline
	puts $fileId2 "[angle $c04 $c05 $c06] " nonewline
	puts $fileId2 "[angle $c05 $c06 $c07] " nonewline
	puts $fileId2 "[angle $c06 $c07 $c08] " nonewline
	puts $fileId2 "[angle $c07 $c08 $c09] " nonewline
	puts $fileId2 "[angle $c08 $c09 $c10] " nonewline
	puts $fileId2 "[angle $c09 $c10 $c11] " nonewline
	puts $fileId2 "[angle $c10 $c11 $c12] " nonewline
	puts $fileId2 "[angle $c11 $c12 $c13] " nonewline
	puts $fileId2 "[angle $c12 $c13 $c14] " nonewline
	puts $fileId2 "[angle $c13 $c14 $c15] " nonewline
	puts $fileId2 "[angle $c14 $c15 $c16] " nonewline
	puts $fileId2 "[angle $c15 $c16 $c17]"

}
close $fileId1
close $fileId2
close $fileId3
