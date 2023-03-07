mol delete all
set aaa {}
set imax 8 ;# x-axis, 3.07 Å * $imax
set jmax 8 ;# y-axis, 5.32 Å * $jmax
# only i or j could upto 100. if imax is 100 then jmax is 10. (actually it is 0 to 9)
# This is because segname of pdb format is allowed for only 4 digits. column 73-76.
lappend aaa 0.0
lappend aaa [expr 5.32*$jmax]
lappend aaa 0.0
###########################################################
####### Carbon
###########################################################
mol load psf ./seed/seed_c1.psf pdb ./seed/seed_c1.pdb

set all [atomselect top "all"]
for {set i 0} {$i < $imax} {incr i} {
	for {set j 0} {$j < $jmax} {incr j} {
		$all writepdb c$i$j.pdb
		$all moveby {0.0 -5.32 0.0}
	}
#	$all moveby {0.0 53.20 0.0}
	$all moveby $aaa
	$all moveby {-3.07 0.0 0.0}
}
mol delete all
for {set i 0} {$i < $imax} {incr i} {
        for {set j 0} {$j < $jmax} {incr j} {
                segment c$i$j {
                        pdb c$i$j.pdb
                        first none
                        last none
                }
                coordpdb c$i$j.pdb c$i$j
        }
}
#writepsf allc.psf
#writepdb allc.pdb

mol delete all
#resetpsf
for {set i 0} {$i < $imax} {incr i} {
        for {set j 0} {$j < $jmax} {incr j} {
		exec rm c$i$j.pdb
	}
}

mol load psf ./seed/seed_c2.psf pdb ./seed/seed_c2.pdb

set all [atomselect top "all"]
for {set i 0} {$i < $imax} {incr i} {
	for {set j 0} {$j < $jmax} {incr j} {
		$all writepdb d$i$j.pdb
		$all moveby {0.0 -5.32 0.0}
	}
#	$all moveby {0.0 53.20 0.0}
	$all moveby $aaa
	$all moveby {-3.07 0.0 0.0}
}
mol delete all
for {set i 0} {$i < $imax} {incr i} {
        for {set j 0} {$j < $jmax} {incr j} {
                segment d$i$j {
                        pdb d$i$j.pdb
                        first none
                        last none
                }
                coordpdb d$i$j.pdb d$i$j
        }
}

mol delete all
for {set i 0} {$i < $imax} {incr i} {
        for {set j 0} {$j < $jmax} {incr j} {
		exec rm d$i$j.pdb
	}
}

mol load psf ./seed/seed_c3.psf pdb ./seed/seed_c3.pdb

set all [atomselect top "all"]
for {set i 0} {$i < $imax} {incr i} {
	for {set j 0} {$j < $jmax} {incr j} {
		$all writepdb e$i$j.pdb
		$all moveby {0.0 -5.32 0.0}
	}
#	$all moveby {0.0 53.20 0.0}
	$all moveby $aaa
	$all moveby {-3.07 0.0 0.0}
}
mol delete all
for {set i 0} {$i < $imax} {incr i} {
        for {set j 0} {$j < $jmax} {incr j} {
                segment e$i$j {
                        pdb e$i$j.pdb
                        first none
                        last none
                }
                coordpdb e$i$j.pdb e$i$j
        }
}

mol delete all
for {set i 0} {$i < $imax} {incr i} {
        for {set j 0} {$j < $jmax} {incr j} {
		exec rm e$i$j.pdb
	}
}

mol load psf ./seed/seed_c4.psf pdb ./seed/seed_c4.pdb

set all [atomselect top "all"]
for {set i 0} {$i < $imax} {incr i} {
	for {set j 0} {$j < $jmax} {incr j} {
		$all writepdb f$i$j.pdb
		$all moveby {0.0 -5.32 0.0}
	}
#	$all moveby {0.0 53.20 0.0}
	$all moveby $aaa
	$all moveby {-3.07 0.0 0.0}
}
mol delete all
for {set i 0} {$i < $imax} {incr i} {
        for {set j 0} {$j < $jmax} {incr j} {
                segment f$i$j {
                        pdb f$i$j.pdb
                        first none
                        last none
                }
                coordpdb f$i$j.pdb f$i$j
        }
}

mol delete all
for {set i 0} {$i < $imax} {incr i} {
        for {set j 0} {$j < $jmax} {incr j} {
		exec rm f$i$j.pdb
	}
}
###########################################################
####### Oxygen
###########################################################
mol load psf ./seed/seed_oh1.psf pdb ./seed/seed_oh1.pdb

set all [atomselect top "all"]
for {set i 0} {$i < $imax} {incr i} {
	for {set j 0} {$j < $jmax} {incr j} {
		$all writepdb o$i$j.pdb
		$all moveby {0.0 -5.32 0.0}
	}
#	$all moveby {0.0 53.20 0.0}
	$all moveby $aaa
	$all moveby {-3.07 0.0 0.0}
}
mol delete all
for {set i 0} {$i < $imax} {incr i} {
        for {set j 0} {$j < $jmax} {incr j} {
                segment o$i$j {
                        pdb o$i$j.pdb
                        first none
                        last none
                }
                coordpdb o$i$j.pdb o$i$j
        }
}

mol delete all
for {set i 0} {$i < $imax} {incr i} {
        for {set j 0} {$j < $jmax} {incr j} {
		exec rm o$i$j.pdb
	}
}

mol load psf ./seed/seed_oh2.psf pdb ./seed/seed_oh2.pdb

set all [atomselect top "all"]
for {set i 0} {$i < $imax} {incr i} {
	for {set j 0} {$j < $jmax} {incr j} {
		$all writepdb p$i$j.pdb
		$all moveby {0.0 -5.32 0.0}
	}
#	$all moveby {0.0 53.20 0.0}
	$all moveby $aaa
	$all moveby {-3.07 0.0 0.0}
}
mol delete all
for {set i 0} {$i < $imax} {incr i} {
        for {set j 0} {$j < $jmax} {incr j} {
                segment p$i$j {
                        pdb p$i$j.pdb
                        first none
                        last none
                }
                coordpdb p$i$j.pdb p$i$j
        }
}

mol delete all
for {set i 0} {$i < $imax} {incr i} {
        for {set j 0} {$j < $jmax} {incr j} {
		exec rm p$i$j.pdb
	}
}

mol load psf ./seed/seed_oh3.psf pdb ./seed/seed_oh3.pdb

set all [atomselect top "all"]
for {set i 0} {$i < $imax} {incr i} {
	for {set j 0} {$j < $jmax} {incr j} {
		$all writepdb q$i$j.pdb
		$all moveby {0.0 -5.32 0.0}
	}
#	$all moveby {0.0 53.20 0.0}
	$all moveby $aaa
	$all moveby {-3.07 0.0 0.0}
}
mol delete all
for {set i 0} {$i < $imax} {incr i} {
        for {set j 0} {$j < $jmax} {incr j} {
                segment q$i$j {
                        pdb q$i$j.pdb
                        first none
                        last none
                }
                coordpdb q$i$j.pdb q$i$j
        }
}

mol delete all
for {set i 0} {$i < $imax} {incr i} {
        for {set j 0} {$j < $jmax} {incr j} {
		exec rm q$i$j.pdb
	}
}

mol load psf ./seed/seed_oh4.psf pdb ./seed/seed_oh4.pdb

set all [atomselect top "all"]
for {set i 0} {$i < $imax} {incr i} {
	for {set j 0} {$j < $jmax} {incr j} {
		$all writepdb r$i$j.pdb
		$all moveby {0.0 -5.32 0.0}
	}
#	$all moveby {0.0 53.20 0.0}
	$all moveby $aaa
	$all moveby {-3.07 0.0 0.0}
}
mol delete all
for {set i 0} {$i < $imax} {incr i} {
        for {set j 0} {$j < $jmax} {incr j} {
                segment r$i$j {
                        pdb r$i$j.pdb
                        first none
                        last none
                }
                coordpdb r$i$j.pdb r$i$j
        }
}

mol delete all
for {set i 0} {$i < $imax} {incr i} {
        for {set j 0} {$j < $jmax} {incr j} {
		exec rm r$i$j.pdb
	}
}
###########################################################
####### Titanium 
###########################################################
mol load psf ./seed/seed_ti1.psf pdb ./seed/seed_ti1.pdb

set all [atomselect top "all"]
for {set i 0} {$i < $imax} {incr i} {
	for {set j 0} {$j < $jmax} {incr j} {
		$all writepdb t$i$j.pdb
		$all moveby {0.0 -5.32 0.0}
	}
#	$all moveby {0.0 53.20 0.0}
	$all moveby $aaa
	$all moveby {-3.07 0.0 0.0}
}
mol delete all
for {set i 0} {$i < $imax} {incr i} {
        for {set j 0} {$j < $jmax} {incr j} {
                segment t$i$j {
                        pdb t$i$j.pdb
                        first none
                        last none
                }
                coordpdb t$i$j.pdb t$i$j
        }
}

mol delete all
for {set i 0} {$i < $imax} {incr i} {
        for {set j 0} {$j < $jmax} {incr j} {
		exec rm t$i$j.pdb
	}
}

mol load psf ./seed/seed_ti2.psf pdb ./seed/seed_ti2.pdb

set all [atomselect top "all"]
for {set i 0} {$i < $imax} {incr i} {
	for {set j 0} {$j < $jmax} {incr j} {
		$all writepdb u$i$j.pdb
		$all moveby {0.0 -5.32 0.0}
	}
#	$all moveby {0.0 53.20 0.0}
	$all moveby $aaa
	$all moveby {-3.07 0.0 0.0}
}
mol delete all
for {set i 0} {$i < $imax} {incr i} {
        for {set j 0} {$j < $jmax} {incr j} {
                segment u$i$j {
                        pdb u$i$j.pdb
                        first none
                        last none
                }
                coordpdb u$i$j.pdb u$i$j
        }
}

mol delete all
for {set i 0} {$i < $imax} {incr i} {
        for {set j 0} {$j < $jmax} {incr j} {
		exec rm u$i$j.pdb
	}
}

mol load psf ./seed/seed_ti3.psf pdb ./seed/seed_ti3.pdb

set all [atomselect top "all"]
for {set i 0} {$i < $imax} {incr i} {
	for {set j 0} {$j < $jmax} {incr j} {
		$all writepdb v$i$j.pdb
		$all moveby {0.0 -5.32 0.0}
	}
#	$all moveby {0.0 53.20 0.0}
	$all moveby $aaa
	$all moveby {-3.07 0.0 0.0}
}
mol delete all
for {set i 0} {$i < $imax} {incr i} {
        for {set j 0} {$j < $jmax} {incr j} {
                segment v$i$j {
                        pdb v$i$j.pdb
                        first none
                        last none
                }
                coordpdb v$i$j.pdb v$i$j
        }
}

mol delete all
for {set i 0} {$i < $imax} {incr i} {
        for {set j 0} {$j < $jmax} {incr j} {
		exec rm v$i$j.pdb
	}
}

mol load psf ./seed/seed_ti4.psf pdb ./seed/seed_ti4.pdb

set all [atomselect top "all"]
for {set i 0} {$i < $imax} {incr i} {
	for {set j 0} {$j < $jmax} {incr j} {
		$all writepdb w$i$j.pdb
		$all moveby {0.0 -5.32 0.0}
	}
#	$all moveby {0.0 53.20 0.0}
	$all moveby $aaa
	$all moveby {-3.07 0.0 0.0}
}
mol delete all
for {set i 0} {$i < $imax} {incr i} {
        for {set j 0} {$j < $jmax} {incr j} {
                segment w$i$j {
                        pdb w$i$j.pdb
                        first none
                        last none
                }
                coordpdb w$i$j.pdb w$i$j
        }
}

mol delete all
for {set i 0} {$i < $imax} {incr i} {
        for {set j 0} {$j < $jmax} {incr j} {
		exec rm w$i$j.pdb
	}
}

mol load psf ./seed/seed_ti5.psf pdb ./seed/seed_ti5.pdb

set all [atomselect top "all"]
for {set i 0} {$i < $imax} {incr i} {
	for {set j 0} {$j < $jmax} {incr j} {
		$all writepdb x$i$j.pdb
		$all moveby {0.0 -5.32 0.0}
	}
#	$all moveby {0.0 53.20 0.0}
	$all moveby $aaa
	$all moveby {-3.07 0.0 0.0}
}
mol delete all
for {set i 0} {$i < $imax} {incr i} {
        for {set j 0} {$j < $jmax} {incr j} {
                segment x$i$j {
                        pdb x$i$j.pdb
                        first none
                        last none
                }
                coordpdb x$i$j.pdb x$i$j
        }
}

mol delete all
for {set i 0} {$i < $imax} {incr i} {
        for {set j 0} {$j < $jmax} {incr j} {
		exec rm x$i$j.pdb
	}
}

mol load psf ./seed/seed_ti6.psf pdb ./seed/seed_ti6.pdb

set all [atomselect top "all"]
for {set i 0} {$i < $imax} {incr i} {
	for {set j 0} {$j < $jmax} {incr j} {
		$all writepdb y$i$j.pdb
		$all moveby {0.0 -5.32 0.0}
	}
#	$all moveby {0.0 53.20 0.0}
	$all moveby $aaa
	$all moveby {-3.07 0.0 0.0}
}
mol delete all
for {set i 0} {$i < $imax} {incr i} {
        for {set j 0} {$j < $jmax} {incr j} {
                segment y$i$j {
                        pdb y$i$j.pdb
                        first none
                        last none
                }
                coordpdb y$i$j.pdb y$i$j
        }
}

mol delete all
for {set i 0} {$i < $imax} {incr i} {
        for {set j 0} {$j < $jmax} {incr j} {
		exec rm y$i$j.pdb
	}
}

###########################################################
writepsf temp1.psf
writepdb temp1.pdb

mol load psf temp1.psf pdb temp1.pdb
resetpsf

set all [atomselect top "all"]
$all moveby [vecinvert [measure center $all]]
$all writepdb temp1.pdb


