#!/usr/bin/tclsh

proc conv file {
set f [open $file r]

set filename "${file}.tmp"
set fileId [open $filename "a"]

for {set i 1} {$i < 83} {incr i} {
	gets $f line
	if {$i == 2} {
		puts $fileId "$line"
	}
	if {$i > 2 && $i < 83} {
		set vx($i) [lindex $line 4]
		set vy($i) [lindex $line 5]
		set vz($i) [lindex $line 6]
#		puts $fileId "$i x = $vx($i), y = $vy($i), z = $vz($i)"
#		catch {puts $fileId "$vx(5) $vy(5) $vz(5)"}
	}
}
puts $fileId "0        1         2         3         4         5         6         7   "
puts $fileId "1234567890123456789012345678901234567890123456789012345678901234567890123"
puts $fileId [format "ATOM     81  P   EBT     4   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(9) $vy(9) $vz(9)]
puts $fileId [format "ATOM     82  O1P EBT     4   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(50) $vy(50) $vz(50)]
puts $fileId [format "ATOM     83  O2P EBT     4   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(49) $vy(49) $vz(49)]
puts $fileId [format "ATOM     84  O3* EBT     4   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(10) $vy(10) $vz(10)]
puts $fileId [format "ATOM     85  H1A EBT     4   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(76) $vy(76) $vz(76)]
puts $fileId [format "ATOM     86  C1* EBT     4   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(37) $vy(37) $vz(37)]
puts $fileId [format "ATOM     87  H1B EBT     4   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(77) $vy(77) $vz(77)]
puts $fileId [format "ATOM     88  N1  EBT     4   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(38) $vy(38) $vz(38)]
puts $fileId [format "ATOM     89  C6  EBT     4   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(43) $vy(43) $vz(43)]
puts $fileId [format "ATOM     90  H6  EBT     4   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(79) $vy(79) $vz(79)]
puts $fileId [format "ATOM     91  C2  EBT     4   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(39) $vy(39) $vz(39)]
puts $fileId [format "ATOM     92  O2  EBT     4   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(44) $vy(44) $vz(44)]
puts $fileId [format "ATOM     93  N3  EBT     4   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(40) $vy(40) $vz(40)]
puts $fileId [format "ATOM     94  H3  EBT     4   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(78) $vy(78) $vz(78)]
puts $fileId [format "ATOM     95  C4  EBT     4   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(41) $vy(41) $vz(41)]
puts $fileId [format "ATOM     96  O4  EBT     4   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(45) $vy(45) $vz(45)]
puts $fileId [format "ATOM     97  C5  EBT     4   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(42) $vy(42) $vz(42)]
puts $fileId [format "ATOM     98  C5M EBT     4   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(46) $vy(46) $vz(46)]
puts $fileId [format "ATOM     99  H51 EBT     4   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(80) $vy(80) $vz(80)]
puts $fileId [format "ATOM    100  H52 EBT     4   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(81) $vy(81) $vz(81)]
puts $fileId [format "ATOM    101  H53 EBT     4   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(82) $vy(82) $vz(82)]
puts $fileId [format "ATOM    102  C2* EBT     4   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(12) $vy(12) $vz(12)]
puts $fileId [format "ATOM    103  H2A EBT     4   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(60) $vy(60) $vz(60)]
puts $fileId [format "ATOM    104  O2* EBT     4   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(13) $vy(13) $vz(13)]
puts $fileId [format "ATOM    105  HO2 EBT     4   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(61) $vy(61) $vz(61)]
puts $fileId [format "ATOM    106  C3* EBT     4   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(11) $vy(11) $vz(11)]
puts $fileId [format "ATOM    107  H3A EBT     4   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(58) $vy(58) $vz(58)]
puts $fileId [format "ATOM    108  H3B EBT     4   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(59) $vy(59) $vz(59)]
puts $fileId [format "ATOM    109  P   GTB     5   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(4) $vy(4) $vz(4)]
puts $fileId [format "ATOM    110  O1P GTB     5   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(48) $vy(48) $vz(48)]
puts $fileId [format "ATOM    111  O2P GTB     5   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(47) $vy(47) $vz(47)]
puts $fileId [format "ATOM    112  O3* GTB     5   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(5) $vy(5) $vz(5)]
puts $fileId [format "ATOM    113  H1B GTB     5   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(69) $vy(69) $vz(69)]
puts $fileId [format "ATOM    114  C1* GTB     5   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(27) $vy(27) $vz(27)]
puts $fileId [format "ATOM    115  H1A GTB     5   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(70) $vy(70) $vz(70)]
puts $fileId [format "ATOM    116  N1  GTB     5   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(28) $vy(28) $vz(28)]
puts $fileId [format "ATOM    117  C6  GTB     5   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(33) $vy(33) $vz(33)]
puts $fileId [format "ATOM    118  H6  GTB     5   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(71) $vy(71) $vz(71)]
puts $fileId [format "ATOM    119  C2  GTB     5   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(29) $vy(29) $vz(29)]
puts $fileId [format "ATOM    120  O2  GTB     5   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(34) $vy(34) $vz(34)]
puts $fileId [format "ATOM    121  N3  GTB     5   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(30) $vy(30) $vz(30)]
puts $fileId [format "ATOM    122  H3  GTB     5   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(72) $vy(72) $vz(72)]
puts $fileId [format "ATOM    123  C4  GTB     5   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(31) $vy(31) $vz(31)]
puts $fileId [format "ATOM    124  O4  GTB     5   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(35) $vy(35) $vz(35)]
puts $fileId [format "ATOM    125  C5  GTB     5   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(32) $vy(32) $vz(32)]
puts $fileId [format "ATOM    126  C5M GTB     5   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(36) $vy(36) $vz(36)]
puts $fileId [format "ATOM    127  H51 GTB     5   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(73) $vy(73) $vz(73)]
puts $fileId [format "ATOM    128  H52 GTB     5   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(74) $vy(74) $vz(74)]
puts $fileId [format "ATOM    129  H53 GTB     5   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(75) $vy(75) $vz(75)]
puts $fileId [format "ATOM    130  C2* GTB     5   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(7) $vy(7) $vz(7)]
puts $fileId [format "ATOM    131  H2A GTB     5   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(57) $vy(57) $vz(57)]
puts $fileId [format "ATOM    132  O2* GTB     5   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(8) $vy(8) $vz(8)]
puts $fileId [format "ATOM    133  C3* GTB     5   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(6) $vy(6) $vz(6)]
puts $fileId [format "ATOM    134  H3A GTB     5   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(55) $vy(55) $vz(55)]
puts $fileId [format "ATOM    135  H3B GTB     5   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(56) $vy(56) $vz(56)]
puts $fileId [format "ATOM    136  HO3 SB      6   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(51) $vy(51) $vz(51)]
puts $fileId [format "ATOM    137  O3* SB      6   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(16) $vy(16) $vz(16)]
puts $fileId [format "ATOM    138  H1B SB      6   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(62) $vy(62) $vz(62)]
puts $fileId [format "ATOM    139  C1* SB      6   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(17) $vy(17) $vz(17)]
puts $fileId [format "ATOM    140  H1A SB      6   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(63) $vy(63) $vz(63)]
puts $fileId [format "ATOM    141  N1  SB      6   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(18) $vy(18) $vz(18)]
puts $fileId [format "ATOM    142  C6  SB      6   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(23) $vy(23) $vz(23)]
puts $fileId [format "ATOM    143  H6  SB      6   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(65) $vy(65) $vz(65)]
puts $fileId [format "ATOM    144  C2  SB      6   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(19) $vy(19) $vz(19)]
puts $fileId [format "ATOM    145  O2  SB      6   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(24) $vy(24) $vz(24)]
puts $fileId [format "ATOM    146  N3  SB      6   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(20) $vy(20) $vz(20)]
puts $fileId [format "ATOM    147  H3  SB      6   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(64) $vy(64) $vz(64)]
puts $fileId [format "ATOM    148  C4  SB      6   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(21) $vy(21) $vz(21)]
puts $fileId [format "ATOM    149  O4  SB      6   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(25) $vy(25) $vz(25)]
puts $fileId [format "ATOM    150  C5  SB      6   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(22) $vy(22) $vz(22)]
puts $fileId [format "ATOM    151  C5M SB      6   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(26) $vy(26) $vz(26)]
puts $fileId [format "ATOM    152  H51 SB      6   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(66) $vy(66) $vz(66)]
puts $fileId [format "ATOM    153  H52 SB      6   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(67) $vy(67) $vz(67)]
puts $fileId [format "ATOM    154  H53 SB      6   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(68) $vy(68) $vz(68)]
puts $fileId [format "ATOM    155  C2* SB      6   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(14) $vy(14) $vz(14)]
puts $fileId [format "ATOM    156  H2A SB      6   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(54) $vy(54) $vz(54)]
puts $fileId [format "ATOM    157  O2* SB      6   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(3) $vy(3) $vz(3)]
puts $fileId [format "ATOM    158  C3* SB      6   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(15) $vy(15) $vz(15)]
puts $fileId [format "ATOM    159  H3A SB      6   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(52) $vy(52) $vz(52)]
puts $fileId [format "ATOM    160  H3B SB      6   %8.3f%8.3f%8.3f  1.00  0.00       AAA" $vx(53) $vy(53) $vz(53)]
puts $fileId "END"
}

#for {set i 1} {$i <=2 } {incr i} {
#	set filename newzmat${i}.pdb
#	conv $filename 	
#}
for {set alpha 60} {$alpha <= 300} {incr alpha 120} {
 for {set beta 60} {$beta <= 300} {incr beta 120} {
  for {set gamma 60} {$gamma <= 300} {incr gamma 120} {
   for {set delta 60} {$delta <= 300} {incr delta 120} {
    for {set epsilon 60} {$epsilon <= 300} {incr epsilon 120} {
     for {set xi1 90} {$xi1 <= 270} {incr xi1 180} {
      for {set xi2 60} {$xi2 <= 300} {incr xi2 120} {

	set filename alpha${alpha}beta${beta}gamma${gamma}delta${delta}epsilon${epsilon}Xa${xi1}Xb${xi2}.pdb
	conv $filename
      }
     }
    }
   }
  }
 }
}
