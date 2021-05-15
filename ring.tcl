# Naman Gupta
##Create a simulator object
set ns [new Simulator]

#Define different colors for data flow (for NAM)

$ns color 1 Blue
$ns color 2 Red
$ns color 3 Green
$ns color 4 Yellow

# open the NAM and TRACE files

set tf1 [open o18041071.tr w]
$ns trace-all $tf1

set nm1 [open o18041071.nam w]
$ns namtrace-all $nm1


#Define the finish procedure

proc finish {} {
	global ns tf1 nm1
	$ns flush-trace
 
#close nam and trace file
	close $tf1 
	close $nm1
	
	exit 0
}

#create 10  nodes

for {set i 0} {$i<8} {incr i} {
set n($i) [$ns node]
}
 


# Create the links between the nodes

for {set i 0} {$i<8} {incr i} {
$ns duplex-link $n($i) $n([expr ($i+1)%8]) 512Kb 5ms RED
}
#Give node position (for NAM)

$ns duplex-link-op $n(0) $n(1) orient right-up
$ns duplex-link-op $n(0) $n(7) orient right-down
$ns duplex-link-op $n(1) $n(2) orient right-up
$ns duplex-link-op $n(7) $n(6) orient right-down
$ns duplex-link-op $n(2) $n(3) orient right-down
$ns duplex-link-op $n(6) $n(5) orient right-up
$ns duplex-link-op $n(3) $n(4) orient right-down
$ns duplex-link-op $n(5) $n(4) orient right-up



$ns duplex-link-op $n(0) $n(1) queuePos 1
$ns duplex-link-op $n(0) $n(7) queuePos 1

$ns duplex-link-op $n(3) $n(4) queuePos 0.5
$ns duplex-link-op $n(3) $n(2) queuePos 0.5

$ns queue-limit $n(0) $n(1) 25
$ns queue-limit $n(0) $n(7) 25


# Setup a TCP connection (ftp1-tcp1-sink1)  

set tcp1 [new Agent/TCP]
$ns attach-agent $n(0) $tcp1

set sink1 [new Agent/TCPSink]
$ns attach-agent $n(5) $sink1

$ns connect $tcp1 $sink1

$tcp1 set fid_ 1
#$tcp1 set packetSize_ 552

set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1 


# Setup a TCP connection (ftp2-tcp2-sink2)

set tcp2 [ new Agent/TCP]
$ns attach-agent $n(2) $tcp2

set sink2 [new Agent/TCPSink]
$ns attach-agent $n(4) $sink2

$ns connect $tcp2 $sink2

$tcp2 set fid_ 2
#$tcp1 set packetSize_ 552

set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2

#Setup UDP connection

set udp1 [new Agent/UDP]
$ns attach-agent $n(3) $udp1

set null1 [new Agent/Null]
$ns attach-agent $n(6) $null1

$ns connect $udp1 $null1

$udp1 set fid_ 3

set cbr1 [new Application/Traffic/CBR]
$cbr1 attach-agent $udp1

#$cbr set packetSize_ 1000
#$cbr set rate_ 0.1Mb
#$cbr set random_ false


#Setup UDP connection

set udp2 [new Agent/UDP]
$ns attach-agent $n(1) $udp2

set null2 [new Agent/Null]
$ns attach-agent $n(7) $null2

$ns connect $udp2 $null2

$udp2 set fid_ 4

set cbr2 [new Application/Traffic/CBR]
$cbr2 attach-agent $udp2

#$cbr set packetSize_ 1000
#$cbr set rate_ 0.1Mb
#$cbr set random_ false


## Schedule

$ns at 0.2 "$ftp1 start"
$ns at 0.2 "$cbr1 start"
$ns at 0.2 "$ftp2 start"
$ns at 0.2 "$cbr2 start"

$ns at 10.5 "$ftp1 stop"
$ns at 10.5 "$cbr1 stop"
$ns at 10.5 "$ftp2 stop"
$ns at 10.5 "$cbr2 stop"

$ns at 11.0 "finish"

$ns run
