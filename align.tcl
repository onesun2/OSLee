#package require La
#package require Orient
namespace import Orient::orient
set all [atomselect top "all"]
set ttt [atomselect top "name CD CG"]
set I [draw principalaxes $ttt]
set A [orient $ttt [lindex $I 2] {0 0 1}]
$all move $A
set I [draw principalaxes $ttt]
set A [orient $ttt [lindex $I 1] {0 1 0}]
$all move $A
set I [draw principalaxes $ttt]

