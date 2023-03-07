#!/usr/bin/tclsh

for {set alpha 60} {$alpha <= 300} {incr alpha 120} {
 for {set beta 60} {$beta <= 300} {incr beta 120} {
  for {set gamma 60} {$gamma <= 300} {incr gamma 120} {
   for {set delta 60} {$delta <= 300} {incr delta 120} {
    for {set epsilon 60} {$epsilon <= 300} {incr epsilon 120} {
     for {set xi1 90} {$xi1 <= 270} {incr xi1 180} {
      for {set xi2 60} {$xi2 <= 300} {incr xi2 120} {
	
	set file test_alpha${alpha}beta${beta}gamma${gamma}delta${delta}epsilon${epsilon}Xa${xi1}Xb${xi2}
	set file2 ${file}.gjf
#	puts "$file"
	catch {exec /usr/local/gaussian/g03/newzmat -izmat -opdb -nofudge -noround -nosymav -order $file2 ${file}.pdb} msg
      }
     }
    }
   }
  }
 }
}
