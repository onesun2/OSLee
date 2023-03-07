#!/usr/bin/tclsh
proc structure_trace {name index op} {
      vmd_calculate_structure $index
}
trace variable vmd_frame w structure_trace

