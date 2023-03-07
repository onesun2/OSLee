#!/usr/bin/tclsh
segment da1 {
pdb dna1a.pdb
last 3ter
}
patch DEO2 DA1:2
patch DEO2 DA1:3
patch DEO2 DA1:4
patch DEO2 DA1:5
patch DEO2 DA1:6
patch DEO2 DA1:7
patch DEO2 DA1:8
patch DEO2 DA1:9
patch DEO2 DA1:10
patch DEO2 DA1:11

coordpdb dna1a.pdb da1

segment da2 {
pdb dna2a.pdb
last 3ter
}
patch DEO2 DA2:2
patch DEO2 DA2:3
patch DEO2 DA2:4
patch DEO2 DA2:5
patch DEO2 DA2:6
patch DEO2 DA2:7
patch DEO2 DA2:8
patch DEO2 DA2:9
patch DEO2 DA2:10
patch DEO2 DA2:11

coordpdb dna2a.pdb da2

segment da3 {
pdb dna3a.pdb
last 3ter
}
patch DEO2 DA3:2
patch DEO2 DA3:3
patch DEO2 DA3:4
patch DEO2 DA3:5
patch DEO2 DA3:6
patch DEO2 DA3:7
patch DEO2 DA3:8
patch DEO2 DA3:9
patch DEO2 DA3:10
patch DEO2 DA3:11

coordpdb dna3a.pdb da3

segment da4 {
pdb dna4a.pdb
last 3ter
}
patch DEO2 DA4:2
patch DEO2 DA4:3
patch DEO2 DA4:4
patch DEO2 DA4:5
patch DEO2 DA4:6
patch DEO2 DA4:7
patch DEO2 DA4:8
patch DEO2 DA4:9
patch DEO2 DA4:10
patch DEO2 DA4:11

coordpdb dna4a.pdb da4

segment gd1 {
pdb gold1.pdb
}

coordpdb gold1.pdb gd1

writepsf temp.psf
guesscoord
writepdb temp.pdb

mol load psf temp.psf pdb temp.pdb

