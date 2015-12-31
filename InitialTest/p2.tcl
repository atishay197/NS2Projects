global s nam_trace all_trace
set s [new Simulator]

set nam_trace [open b.nam w]
set all_trace [open b.trace w]
$s trace-all $all_trace
$s namtrace-all $nam_trace

proc finish {} {
	global s nam_trace all_trace
	$s flush-trace
	close $nam_trace
	close $all_trace
	exit
}

set src [$s node]
set rtr [$s node]
set dst [$s node]

Queue/RED set bytes_ false
Queue/RED set queue_in_bytes_ false
Queue/RED drop_tail_ true
Queue/RED set setbit_ false
Queue/RED set thresh_ 5
Queue/RED set maxthresh_ 10
Queue/RED set q_weight 0.002
Queue/RED set linterm_ 50

$s duplex-link $src $rtr 2Mb 100ms RED
$s duplex-link $rtr $dst 1Mb 100ms RED
$s queue-limit $rtr $dst 30

set link [$s link $rtr $dst]
set queue [$link queue]
set queue_trace [open a.queue w]
$queue trace curq_
$queue trace ave_
$queue attach $queue_trace


set tcp [$s create-connection TCP/Reno $src TCPSink $dst 0]

set ftp [$tcp attach-source FTP]


$s at 0 "$ftp start"
$s at 10 "finish"

$s run 