#!/usr/bin/tclsh

for {set alpha 60} {$alpha <= 300} {incr alpha 120} {
 for {set beta 60} {$beta <= 300} {incr beta 120} {
  for {set gamma 60} {$gamma <= 300} {incr gamma 120} {
   for {set delta 60} {$delta <= 300} {incr delta 120} {
    for {set epsilon 60} {$epsilon <= 300} {incr epsilon 120} {
     for {set xi1 90} {$xi1 <= 270} {incr xi1 180} {
      for {set xi2 60} {$xi2 <= 300} {incr xi2 120} {

	
	set filename2 "head.txt"
	set fileId2 [open $filename2 "w"]

	puts $fileId2 "# HF/6-31G Opt"
	puts $fileId2 " "
	puts $fileId2 "alpha=$alpha, beta=$beta, gamma=$gamma, delta=$delta, epsilon=$epsilon, xi1=$xi1, xi2=$xi2"
	puts $fileId2 " "
	puts $fileId2 "0 1"
	close $fileId2

	set filename "alpha${alpha}beta${beta}gamma${gamma}delta${delta}epsilon${epsilon}Xa${xi1}Xb${xi2}.gjf"
	set fileId [open $filename "w"]

#	puts $fileId "D4 = $alpha"
#	puts $fileId "D5 = $beta"
#	puts $fileId "D6 = $gamma"
#	puts $fileId "D7 = $delta"
#	puts $fileId "D8 = $epsilon"
#	puts $fileId "D9 = $xi1"
#	puts $fileId "D10 = $xi2"
#----------------------------------------------------------
	puts $fileId "dih4     ${alpha}."  	 	
	puts $fileId "dih5     ${beta}."    	
	puts $fileId "dih6     ${gamma}."   
	puts $fileId "dih7     ${delta}."  
	puts $fileId "dih8     ${epsilon}." 		
	puts $fileId "dih9     ${alpha}."   	
	puts $fileId "dih10    ${beta}."    	
	puts $fileId "dih11    ${gamma}."      	
	puts $fileId "dih12    ${epsilon}."     	
	puts $fileId "dih13    ${delta}."   	
	puts $fileId "dih14    ${gamma}."   	
	puts $fileId "dih15    [expr $gamma + 120.0]"	
	puts $fileId "dih16    ${xi2}."  	 	
	puts $fileId "dih17    ${xi1}."   	
	puts $fileId "dih18    180.0"    	
	puts $fileId "dih19      0.0"    	
	puts $fileId "dih20      0.0"    	
	puts $fileId "dih21      0.0"    	
	puts $fileId "dih22      0.0"    	
	puts $fileId "dih23    180.0"    	
	puts $fileId "dih24    180.0"    	
	puts $fileId "dih25    [expr $delta - 120.0]"	
	puts $fileId "dih26    [expr ${xi2} + 120.0]"	
	puts $fileId "dih27    ${xi1}."  		
	puts $fileId "dih28    180.0"    		
	puts $fileId "dih29      0.0"    		
	puts $fileId "dih30      0.0"    		
	puts $fileId "dih31    [expr ${xi1} - 180.0]"	
	puts $fileId "dih32      0.0"    		
	puts $fileId "dih33    180.0"    		
	puts $fileId "dih34    180.0"    		
	puts $fileId "dih35    [expr $gamma + 120.0]"	
	puts $fileId "dih36    [expr ${xi2} + 120.0]"	
	puts $fileId "dih37    ${xi1}."   		
	puts $fileId "dih38    180.0"    		
	puts $fileId "dih39      0.0"    		
	puts $fileId "dih40      0.0"    		
	puts $fileId "dih41    [expr ${xi1} + 180.0]"	
	puts $fileId "dih42      0.0"    		
	puts $fileId "dih43    180.0"    		
	puts $fileId "dih44    180.0"    		
	puts $fileId "dih45    [expr $epsilon - 240.0]"	
	puts $fileId "dih46    [expr $epsilon - 120.0]"	
	puts $fileId "dih47    [expr $alpha - 120.0]"	
	puts $fileId "dih48    [expr $alpha + 120.0]"	
	puts $fileId "dih49    ${beta}."    		
	puts $fileId "dih50    [expr $gamma + 120.0]"	
	puts $fileId "dih51    [expr $gamma + 240.0]"	
	puts $fileId "dih52    [expr $gamma + 240.0]"	
	puts $fileId "dih53    [expr $beta - 120.0]"	
	puts $fileId "dih54    [expr $beta + 120.0]"	
	puts $fileId "dih55    [expr $delta + 120.0]"	
	puts $fileId "dih56    [expr $beta - 120.0]"	
	puts $fileId "dih57    [expr $beta - 240.0]"	
	puts $fileId "dih58    [expr ${xi2} + 240.0]"	
	puts $fileId "dih59    [expr $delta - 120.0]"	
	puts $fileId "dih60    [expr ${xi1} - 120.0]"
	puts $fileId "dih61    [expr ${xi1} + 120.0]"
	puts $fileId "dih62    180.0"    		
	puts $fileId "dih63    180.0"    		
	puts $fileId "dih64    -60.0"    		
	puts $fileId "dih65     60.0"    		
	puts $fileId "dih66    180.0"    		
	puts $fileId "dih67    [expr ${xi1} - 60.0]"
	puts $fileId "dih68    [expr ${xi1} + 60.0]"
	puts $fileId "dih69      0.0"    		
	puts $fileId "dih70    180.0"    	
	puts $fileId "dih71    120.0"        	
	puts $fileId "dih72   -120.0"    	
	puts $fileId "dih73      0.0"     	
	puts $fileId "dih74    [expr ${xi1} - 60.0]"
	puts $fileId "dih75    [expr ${xi1} + 60.0]"
	puts $fileId "dih76    180.0"    	
	puts $fileId "dih77      0.0"    	
	puts $fileId "dih78    120.0"    	
	puts $fileId "dih79   -120.0"    	
	puts $fileId "dih80      0.0"    	
	puts $fileId " "

#----------------------------------------------------------
	close $fileId
	
	exec cat head.txt main.txt alpha${alpha}beta${beta}gamma${gamma}delta${delta}epsilon${epsilon}Xa${xi1}Xb${xi2}.gjf > test_alpha${alpha}beta${beta}gamma${gamma}delta${delta}epsilon${epsilon}Xa${xi1}Xb${xi2}.gjf

	exec rm head.txt
      }
     }
    }
   }
  }
 }
}
