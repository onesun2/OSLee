#!/usr/bin/tclsh
set sm 3
set em 18
set state water
set numofmon 20
set filename "num_vdw${sm}to$em.txt"
set fileId [open $filename "w"]
set num_steps [molinfo top get numframes]
set vdw [atomselect top "segname TUB and (within 3.47 of segname PLY) and (resid $sm to $em)"]

###################################################################
###           MAIN                                             ####
###################################################################
for {set frame 0} {$frame < $num_steps} {incr frame} {
#	puts "frame = $frame"
	$vdw frame $frame
	$vdw update
	puts $fileId "num_vdw = [$vdw num]"
#	puts "vdw = [$vdw num]"
}
close $fileId
