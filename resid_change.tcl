for {set i 1} {$i < 10} {incr i} {
	set ttt($i) [atomselect top "resid $i"]
}
for {set i 28} {$i < 67} {incr i} {
	set ttt($i) [atomselect top "resid $i"]
}
for {set i 67} {$i < 107} {incr i} {
	set ttt($i) [atomselect top "resid $i"]
}
for {set i 107} {$i < 169} {incr i} {
	set ttt($i) [atomselect top "resid $i"]
}
for {set i 169} {$i < 201} {incr i} {
	set ttt($i) [atomselect top "resid $i"]
}
for {set i 203} {$i < 215} {incr i} {
	set ttt($i) [atomselect top "resid $i"]
}


for {set i 1} {$i < 10} {incr i} {
	$ttt($i) set resid [expr 1+$i]
	puts [$ttt($i) get resid]
}

for {set i 28} {$i < 67} {incr i} {
	$ttt($i) set resid [expr 2+$i]
	puts [$ttt($i) get resid]
}

for {set i 67} {$i < 107} {incr i} {
	$ttt($i) set resid [expr 4+$i]
	puts [$ttt($i) get resid]
}

for {set i 107} {$i < 169} {incr i} {
	$ttt($i) set resid [expr 5+$i]
	puts [$ttt($i) get resid]
}

for {set i 169} {$i < 201} {incr i} {
	$ttt($i) set resid [expr 4+$i]
	puts [$ttt($i) get resid]
}

for {set i 203} {$i < 215} {incr i} {
	$ttt($i) set resid [expr 2+$i]
	puts [$ttt($i) get resid]
}
