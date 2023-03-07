#!/usr/bin/tclsh
#set ss [atomselect top "name SS"]
#$ss get index
#{45 99 153 207 261 315 369 423 477 531}
#carbon1: S_index - 5
#carbon2: S_index + 3

set s0 [atomselect top "index 45"]
set s0c1 [atomselect top "index 40"]
set s0c2 [atomselect top "index 48"]
set s0move1 [atomselect top "index < 45"]
set s0move2 [atomselect top "index > 45"]

set s1 [atomselect top "index 99"]
set s1c1 [atomselect top "index 94"]
set s1c2 [atomselect top "index 102"]
set s1move1 [atomselect top "index < 99"]
set s1move2 [atomselect top "index > 99"]

set s2 [atomselect top "index 153"]
set s2c1 [atomselect top "index 148"]
set s2c2 [atomselect top "index 156"]
set s2move1 [atomselect top "index < 153"]
set s2move2 [atomselect top "index > 153"]

set s3 [atomselect top "index 207"]
set s3c1 [atomselect top "index 202"]
set s3c2 [atomselect top "index 210"]
set s3move1 [atomselect top "index < 207"]
set s3move2 [atomselect top "index > 207"]

set s4 [atomselect top "index 261"]
set s4c1 [atomselect top "index 256"]
set s4c2 [atomselect top "index 264"]
set s4move1 [atomselect top "index < 261"]
set s4move2 [atomselect top "index > 261"]

set s5 [atomselect top "index 315"]
set s5c1 [atomselect top "index 310"]
set s5c2 [atomselect top "index 318"]
set s5move1 [atomselect top "index < 315"]
set s5move2 [atomselect top "index > 315"]

set s6 [atomselect top "index 369"]
set s6c1 [atomselect top "index 364"]
set s6c2 [atomselect top "index 372"]
set s6move1 [atomselect top "index < 369"]
set s6move2 [atomselect top "index > 369"]

set s7 [atomselect top "index 423"]
set s7c1 [atomselect top "index 418"]
set s7c2 [atomselect top "index 426"]
set s7move1 [atomselect top "index < 423"]
set s7move2 [atomselect top "index > 423"]

set s8 [atomselect top "index 477"]
set s8c1 [atomselect top "index 472"]
set s8c2 [atomselect top "index 480"]
set s8move1 [atomselect top "index < 477"]
set s8move2 [atomselect top "index > 477"]

set s9 [atomselect top "index 531"]
set s9c1 [atomselect top "index 526"]
set s9c2 [atomselect top "index 534"]
set s9move1 [atomselect top "index < 531"]
set s9move2 [atomselect top "index > 531"]

$s0move1 move [trans bond [lindex [$s0c1 get {x y z}] 0] [lindex [$s0 get {x y z}] 0] 90 deg]
$s0move2 move [trans bond [lindex [$s0 get {x y z}] 0] [lindex [$s0c2 get {x y z}] 0] 90 deg]

$s1move1 move [trans bond [lindex [$s1c1 get {x y z}] 0] [lindex [$s1 get {x y z}] 0] 90 deg]
$s1move2 move [trans bond [lindex [$s1 get {x y z}] 0] [lindex [$s1c2 get {x y z}] 0] 90 deg]

$s2move1 move [trans bond [lindex [$s2c1 get {x y z}] 0] [lindex [$s2 get {x y z}] 0] 90 deg]
$s2move2 move [trans bond [lindex [$s2 get {x y z}] 0] [lindex [$s2c2 get {x y z}] 0] 90 deg]

$s3move1 move [trans bond [lindex [$s3c1 get {x y z}] 0] [lindex [$s3 get {x y z}] 0] 90 deg]
$s3move2 move [trans bond [lindex [$s3 get {x y z}] 0] [lindex [$s3c2 get {x y z}] 0] 90 deg]

$s4move1 move [trans bond [lindex [$s4c1 get {x y z}] 0] [lindex [$s4 get {x y z}] 0] 90 deg]
$s4move2 move [trans bond [lindex [$s4 get {x y z}] 0] [lindex [$s4c2 get {x y z}] 0] 90 deg]

$s5move1 move [trans bond [lindex [$s5c1 get {x y z}] 0] [lindex [$s5 get {x y z}] 0] 90 deg]
$s5move2 move [trans bond [lindex [$s5 get {x y z}] 0] [lindex [$s5c2 get {x y z}] 0] 90 deg]

$s6move1 move [trans bond [lindex [$s6c1 get {x y z}] 0] [lindex [$s6 get {x y z}] 0] 90 deg]
$s6move2 move [trans bond [lindex [$s6 get {x y z}] 0] [lindex [$s6c2 get {x y z}] 0] 90 deg]

$s7move1 move [trans bond [lindex [$s7c1 get {x y z}] 0] [lindex [$s7 get {x y z}] 0] 90 deg]
$s7move2 move [trans bond [lindex [$s7 get {x y z}] 0] [lindex [$s7c2 get {x y z}] 0] 90 deg]

$s8move1 move [trans bond [lindex [$s8c1 get {x y z}] 0] [lindex [$s8 get {x y z}] 0] 90 deg]
$s8move2 move [trans bond [lindex [$s8 get {x y z}] 0] [lindex [$s8c2 get {x y z}] 0] 90 deg]

$s9move1 move [trans bond [lindex [$s9c1 get {x y z}] 0] [lindex [$s9 get {x y z}] 0] 90 deg]
$s9move2 move [trans bond [lindex [$s9 get {x y z}] 0] [lindex [$s9c2 get {x y z}] 0] 90 deg]

