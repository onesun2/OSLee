set ttt [atomselect top "segname H1"]
#set ttt [atomselect top "segname H000 to H999"]
set res [atomselect top "resname IDS"]
draw color yellow
#measure sasa 1.4 $ttt -restrict $res -points sasapoints
measure sasa 1.4 $ttt -points sasapoints
foreach pt $sasapoints {
	draw point $pt
}

