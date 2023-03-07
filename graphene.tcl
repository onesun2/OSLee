package require nanotube 
package require psfgen 
proc writetop {{op ""}} { 
  if {$op=="del"} { 
    file delete tmp.top 
  } else { 
    set fz [open "tmp.top" w] 
    puts $fz "* >>> Top File for C Cluster<<< " 
    puts $fz "0 1 " 
    puts $fz "MASS 21 CA 12.01100 C \n " 
    puts $fz "RESI GRA 0.00 " 
    puts $fz "GROUP " 
    puts $fz "ATOM C CA 0.00 \n " 
    puts $fz "PRES LINC 0.00 " 
    puts $fz "BOND 1C 2C \n " 
    puts $fz "END " 
    close $fz 
  } 
} 
proc graphene2 {x y {output nanotube}} { 
  graphene -lx $x -ly $y -type armchair -nlayers 1
  set sel1 [atomselect top all] 
  $sel1 set resid [$sel1 get index] 
  $sel1 writepdb tmp1.pdb 
  writetop 
  resetpsf 
  topology tmp.top 
  segment CCC {pdb tmp1.pdb} 
  set xyz [$sel1 get {x y z}] 
  foreach c1 [$sel1 get resid] { 
    foreach c2 [$sel1 get resid] { 
      set dist [vecdist [lindex $xyz $c1] [lindex $xyz $c2]] 
      if {$c1 < $c2 && $dist < 1.8} { 
        patch LINC CCC:$c1 CCC:$c2 
      } 
    } 
  } 
  coordpdb tmp1.pdb CCC 
  regenerate angles dihedrals 
  writepdb ${output}.pdb 
  writepsf ${output}.psf 
   
  writetop del 
} 