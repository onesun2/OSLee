#!/usr/bin/tclsh
alias residue A ADE
alias residue T THY
alias residue C CYT
alias residue G GUA

segment dn1 {
first 5TER
last 3TER
pdb chaina.pdb
}

;# DEO1 --> patch for pyrmidine, T and C
;# DEO2 --> patch for purine, A and G

patch DEO1 DN1:1
patch DEO2 DN1:2
patch DEO1 DN1:3
patch DEO2 DN1:4
patch DEO2 DN1:5
patch DEO2 DN1:6
patch DEO1 DN1:7
patch DEO1 DN1:8
patch DEO1 DN1:9
patch DEO2 DN1:10
patch DEO1 DN1:11
patch DEO2 DN1:12

coordpdb chaina.pdb dn1

segment dn2 {
first 5TER
last 3TER
pdb chainb.pdb
}

patch DEO1 DN2:13
patch DEO2 DN2:14
patch DEO1 DN2:15
patch DEO2 DN2:16
patch DEO2 DN2:17
patch DEO2 DN2:18
patch DEO1 DN2:19
patch DEO1 DN2:20
patch DEO1 DN2:21
patch DEO2 DN2:22
patch DEO1 DN2:23
patch DEO2 DN2:24

coordpdb chainb.pdb dn2

writepsf ttt.psf
guesscoord
writepdb ttt.pdb

mol load psf ttt.psf pdb ttt.pdb
