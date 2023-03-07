#!/usr/bin/tclsh
set out [open olist.dat w]
set gr1 [atomselect top "segname GR1"]
set gr2 [atomselect top "segname GR2"]
set ttt [atomselect top "segname P000 to P999"]
set ccc {}

#set list1 [measure contacts 2.5 $gr1 $ttt]
set list1 [lindex [measure contacts 4.0 $gr1 $ttt] 1]
set list2 [lindex [measure contacts 4.0 $gr2 $ttt] 1]
set idx1 [[atomselect top "(same segname as (index $list1)) and (name O1)"] get index]
set idx2 [[atomselect top "(same segname as (index $list2)) and (name O1)"] get index]
#puts $idx1
#puts "gr1 [lindex $list1 1]"

foreach i $idx2 {
	if {[lsearch $idx1 $i] >=0} {
		lappend ccc [lindex $idx1 [lsearch $idx1 $i]]
#		puts $out "[lindex $idx1 [lsearch $idx1 $i]]"
	}
}
#mol addrep 1
#mol modselect 1 1 same segname as (index $ccc)
#mol modstyle 1 1 VDW 1.000 12.0000 
puts $out "$ccc"
close $out

