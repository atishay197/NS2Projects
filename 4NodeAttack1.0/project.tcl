set ns [new Simulator]

#tracefile
set f [open project.tr w]
$ns trace-all $f
set n [open project.nam w]
$ns namtrace-all $n


#nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]


#links
$ns duplex-link $n0 $n2 5Mb 100ms DropTail 
$ns duplex-link $n1 $n2 2Mb 100ms DropTail 
$ns duplex-link $n2 $n3 1Mb 20ms DropTail 
$ns queue-limit $n2 $n3 10

#position
$ns duplex-link-op $n0 $n2 orient right-down
$ns duplex-link-op $n1 $n2 orient right-up
$ns duplex-link-op $n2 $n3 orient right

#monitor
$ns duplex-link-op $n2 $n3 queuePos 0.5

#agents tcp
set tcp [new Agent/TCP]
#$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $n0 $tcp
$ns attach-agent $n3 $sink
$ns connect $tcp $sink
$tcp set fid_ 1


#attach-traffic ftp over tcp
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ftp set type_ FTP


set tcp1 [new Agent/TCP]
#$tcp set class_ 2
set sink1 [new Agent/TCPSink]
$ns attach-agent $n0 $tcp1
$ns attach-agent $n2 $sink1
$ns connect $tcp1 $sink1



#attach-traffic ftp over tcp
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ftp1 set type_ FTP1




#schdue events
#$ns at 0.1 "$cbr start"
$ns at 0.5 "$ftp start"
$ns at 5 "$ftp1 start"
$ns at 15 "$ftp1 stop"
$ns at 19 "$ftp stop"

#detac

$ns at 20 "finish"


#wrapper
proc finish {} {
	global ns f n
	close $f
	close $n
	puts "Running nam..."
	exec nam project.nam &
	exit 0
}

$ns run 


















