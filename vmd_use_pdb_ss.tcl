# read the secondary structure records from a file and return
# the information in the form:
#    {SSType chain1 resid1 chain2 resid2} {... }
proc vmd_read_pdb_ss {pdb_filename} {
    set response {}
    # open the PDB file
    set infile [open $pdb_filename r]
    # read until the end of file
    while {[gets $infile line]} {
        set str [string range $line 0 5]
        if {$str == "HELIX "} {
            set ss helix
            set chain1 [string range $line 19 19]
            set resid1 [string range $line 21 24]
            set chain2 [string range $line 31 31]
            set resid2 [string range $line 33 36]
            lappend response [list $ss $chain1 $resid1 $chain2 $resid2]
            continue
        }
        if {$str == "SHEET "} {
            # get the needed fields
            set ss sheet
            set chain1 [string range $line 21 21]
            set resid1 [string range $line 22 25]
            set chain2 [string range $line 32 32]
            set resid2 [string range $line 33 36]
            lappend response [list $ss $chain1 $resid1 $chain2 $resid2]
            continue
        }
        
        # also, if read ATOM then there are no more def's
        if {$str == "ATOM  " || $str == ""} {
            break
        }
    }
    # close the file and return the list of info
    close $infile
    return $response
}

#### Now a driver to get info from this routine
# Return 0 if no information available
# Return 1 otherwise
proc vmd_use_pdb_ss {molid pdb_filename} {
    # get the list of information
    set ssdata [vmd_read_pdb_ss $pdb_filename]
    # was there data?
    if {$ssdata == {}} {return 0}

#rlc's modification: first, reset everything to coil as a default
    set sel_all [atomselect $molid "all"]
    $sel_all set structure coil
    
    # Go through each of the element
    foreach ele $ssdata {
        lassign $ele ss chain1 resid1 chain2 resid2
        # if the chains are " ", don't use them
        if {$chain1 == " "} {
            set seltext "protein and (resid $resid1 to $resid2)"
        } else {
            set seltext "chain $chain1 and (resid $resid1 to $resid2)"
        }
        # get the selection/ make it the right structure/ free it
        set sel [atomselect $molid $seltext]
        $sel set structure $ss
        $sel delete
    }
    # all done, so return that I did something
    return 1
}