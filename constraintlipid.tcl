#!/usr/bin/tclsh
set all [atomselect top "all"]
set core1 [atomselect top "(segname MEM) and ((x-14.3)*(x-14.3)+(y-6.7)*(y-6.7)<160*160)"]
set core2 [atomselect top "(segname MEM) and ((x-14.3)*(x-14.3)+(y-6.7)*(y-6.7)>160*160) and ((x-14.3)*(x-14.3)+(y-6.7)*(y-6.7)<180*180)"]
set core3 [atomselect top "(segname MEM) and ((x-14.3)*(x-14.3)+(y-6.7)*(y-6.7)>180*180)"]

$core1 set beta 0.0
$core2 set beta 10.0
$core3 set beta 999.0

$all writepdb fixlipid2.pdb

