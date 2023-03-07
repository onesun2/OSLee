set all [atomselect top "all"]
set ttt [atomselect top "segname GR1 GR2"]
$all set beta 0
$ttt set beta 1
$all writepdb fix.pdb


