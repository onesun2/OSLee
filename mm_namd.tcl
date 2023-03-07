#!/usr/bin/tclsh

for {set alpha 60} {$alpha <= 300} {incr alpha 120} {
 for {set beta 60} {$beta <= 300} {incr beta 120} {
  for {set gamma 60} {$gamma <= 300} {incr gamma 120} {
   for {set delta 60} {$delta <= 300} {incr delta 120} {
    for {set epsilon 60} {$epsilon <= 300} {incr epsilon 120} {
     for {set xi1 90} {$xi1 <= 270} {incr xi1 180} {
      for {set xi2 60} {$xi2 <= 300} {incr xi2 120} {

	set filename "alpha${alpha}beta${beta}gamma${gamma}delta${delta}epsilon${epsilon}Xa${xi1}Xb${xi2}.conf"
	set fileId [open $filename "w"]
	
	puts $fileId "#GNA energy minimization input."
	puts $fileId "#alpha=$alpha, beta=$beta, gamma=$gamma, delta=$delta, xi1=$xi1, xi2=$xi2"
	puts $fileId "structure test2.psf"
	puts $fileId "coordinates alpha${alpha}beta${beta}gamma${gamma}delta${delta}epsilon${epsilon}Xa${xi1}Xb${xi2}.pdb"

	puts $fileId "set temperature 0.0"
	puts $fileId "temperature \$temperature"

	puts $fileId "outputName ./results/alpha${alpha}beta${beta}gamma${gamma}delta${delta}epsilon${epsilon}Xa${xi1}Xb${xi2}mm"

	puts $fileId "restartfreq 10"
	puts $fileId "dcdfreq 10"
	puts $fileId "xstfreq 10"
	puts $fileId "outputEnergies 10"
	puts $fileId "outputTiming 10"
	puts $fileId "paratypecharmm on"
	puts $fileId "parameters onesunpar2.inp"

	puts $fileId "exclude scaled1-4"
	puts $fileId "1-4scaling 1.0"
	puts $fileId "switching on"
	puts $fileId "switchdist 48"
	puts $fileId "cutoff 50"
	puts $fileId "pairlistdist 52"
	puts $fileId "stepspercycle 5"
	puts $fileId "timestep 1.0"
	puts $fileId "minimize 10000"

	set filename2 "run.csh"
	set fileId2 [open $filename2 "a"]
	puts $fileId2 "#!/bin/tcsh"
	puts $fileId2 "/Applications/NAMD_2.5_MacOSX-PPC/namd2 alpha${alpha}beta${beta}gamma${gamma}delta${delta}epsilon${epsilon}Xa${xi1}Xb${xi2}.conf > alpha${alpha}beta${beta}gamma${gamma}delta${delta}epsilon${epsilon}Xa${xi1}Xb${xi2}.res"

	close $fileId2
	close $fileId
	
      }
     }
    }
   }
  }
 }
}
