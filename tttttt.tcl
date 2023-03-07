package require La

namespace eval ::Tttttt:: {
    namespace export orient
}

# package require Tttttt
# namespace import Tttttt::orient
# ... load your molecules and make a selection ...
#
# set I [cusp principalaxes $sel]           <--- show/calc the principal axes
# set A [orient $sel [lindex $I 2] {0 0 1}] <--- rotate axis 2 to match Z
# $sel move $A
# set I [cusp principalaxes $sel]           <--- recalc principal axes to check
# set A [orient $sel [lindex $I 1] {0 1 0}] <--- rotate axis 1 to match Y
# $sel move $A
# set I [cusp principalaxes $sel]           <--- recalc principal axes to check#
proc Tttttt::sel_com { sel weights } {
    set x [ $sel get x ]
    set y [ $sel get y ]
    set z [ $sel get z ]
    set m $weights
    
    set comx 0
    set comy 0
    set comz 0
    set totalm 0
    foreach xx $x yy $y zz $z mm $m {
        # use the abs of the weights
        set mm [expr abs($mm)]
	set comx [ expr "$comx + $xx*$mm" ]
	set comy [ expr "$comy + $yy*$mm" ]
	set comz [ expr "$comz + $zz*$mm" ]
	set totalm [ expr "$totalm + $mm" ]
    }
    set comx [ expr "$comx / $totalm" ]
    set comy [ expr "$comy / $totalm" ]
    set comz [ expr "$comz / $totalm" ]
#    puts "Total weight: $totalm"
    return [list $comx $comy $comz]
}

proc Tttttt::sel_it { sel COM weights} {
    set x [ $sel get x ]
    set y [ $sel get y ]
    set z [ $sel get z ]
    set m $weights

    # compute I
    global Ixx Ixy Ixz Iyy Iyz Izz
    set Ixx 0
    set Ixy 0
    set Ixz 0
    set Iyy 0
    set Iyz 0
    set Izz 0
    foreach xx $x yy $y zz $z mm $m {
        # use the abs of the weights
        set mm [expr abs($mm)]
        
        # subtract the COM
        set xx [expr $xx - [lindex $COM 0]]
        set yy [expr $yy - [lindex $COM 1]]
        set zz [expr $zz - [lindex $COM 2]]

        set rr [expr $xx + $yy + $zz]

        set Ixx [expr $Ixx + $mm*($yy*$yy+$zz*$zz)]
        set Ixy [expr $Ixy - $mm*($xx*$yy)]
        set Ixz [expr $Ixz - $mm*($xx*$zz)]
        set Iyy [expr $Iyy + $mm*($xx*$xx+$zz*$zz)]
        set Iyz [expr $Iyz - $mm*($yy*$zz)]
        set Izz [expr $Izz + $mm*($xx*$xx+$yy*$yy)]

    }
    
    return [list 2 3 3 $Ixx $Ixy $Ixz $Ixy $Iyy $Iyz $Ixz $Iyz $Izz]
}

# draws the three principal axes
#proc vmd_draw_principalaxes { mol sel {weights domass} } {
#proc cusp { mol sel {weights domass} } {
proc cusp { sel {weights domass} } {
    if { $weights == "domass" } {
        set weights [ $sel get mass ]
    }

    global a1 a2 a3 COM
    set I [Tttttt::calc_principalaxes $sel $weights]
    set a1 [lindex $I 0]
    set a2 [lindex $I 1]
    set a3 [lindex $I 2]

    set COM [Tttttt::sel_com $sel $weights]
    return [list $a1 $a2 $a3]
}

# returns the three principal axes
proc Tttttt::calc_principalaxes { sel {weights domass} } {
#    puts "Calculating principal axes."
    if { $weights == "domass" } {
        set weights [ $sel get mass ]
    }

#    puts "Getting the center-of-mass..."
    # get the COM
    set COM [Tttttt::sel_com $sel $weights]
#    puts "Computing the inertia tensor..."
    # get the I
    global I
    set I [Tttttt::sel_it $sel $COM $weights]
#    puts "Drawing the principal components..."
    La::mevsvd_br I evals
    # now $I holds in its columns the principal axes
    set a1 "[lindex $I 3] [lindex $I 6] [lindex $I 9]"
    set a2 "[lindex $I 4] [lindex $I 7] [lindex $I 10]"
    set a3 "[lindex $I 5] [lindex $I 8] [lindex $I 11]"

    return [list $a1 $a2 $a3]
}

