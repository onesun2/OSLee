#!/usr/bin/tclsh
segment s11 {
pdb s11.pdb 
last 3ter
}
patch DEO2 S11:1
patch DEO2 S11:2
patch DEO2 S11:3
patch DEO2 S11:4
patch DEO2 S11:5
patch DEO2 S11:6
patch DEO2 S11:7
patch DEO2 S11:8
patch DEO2 S11:9
patch DEO2 S11:10
patch DEO2 S11:11
patch DEO2 S11:12
patch DEO2 S11:13
patch DEO2 S11:14
patch DEO1 S11:15
patch DEO2 S11:16
patch DEO2 S11:17
patch DEO2 S11:18
patch DEO1 S11:19
patch DEO2 S11:20
patch DEO1 S11:21
patch DEO1 S11:22
patch DEO1 S11:23
patch DEO2 S11:24
patch DEO2 S11:25
patch DEO1 S11:26
patch DEO2 S11:27
patch DEO2 S11:28

coordpdb s11.pdb S11 
guesscoord

writepsf ttt.psf
writepdb ttt.pdb

mol load psf ttt.psf pdb ttt.pdb

