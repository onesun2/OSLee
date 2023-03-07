#!/usr/bin/tclsh
package require Tcl 8
#package require math::optimize::solveLinearProgram
package require math::optimize

set solution [::matn::optimize {3.0 2.0} {{1.0 1.0 1.0} {2.0 5.0 10.0}}]
puts "sol= $solution"
