global s nam_trace all_trace
set s [new Simulator]

set nam_trace [open a.nam w]
set all_trace [open a.trace w]
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
set dst [$s node]

$s duplex-link $src $dst 1Mb 100ms DropTail

set tcp [$s create-connection TCP/Reno $src TCPSink $dst 0]

set ftp [$tcp attach-source FTP]


$s at 0 "$ftp start"
$s at 10 "finish"

$s run 