#!/usr/bin/perl
################
######## SSH SCRIPT
##author: iltiscat
#mail:	schmiddim@gmx.at
#web:  	http://schmiddi.co.cc
#date:	02.10.09
#desc: 	a small script for conky:
#	Executes a command via ssh on a foreign server
#use:   First, copy your id to the remote machine via ssh-copy-id. 


$server = @ARGV[0];
$ssh_user = @ARGV[1];

#Enough arguments?
if ($#ARGV<2) {
	print "usage: ssh.pl server user command\n";
	exit (-1);

}#fi

#Machine alive?
$status=  system ("ping -c 1 $server  -t 2 >/dev/null");

#Fetching the Commands
$ctr=0;
$command_string="";
foreach $iter(@ARGV) {

	if ($ctr>1) {
		$command_string.="$iter ";
	}
	$ctr++;
}#each

#Execute the Command
if ($status ==0 ) {
	$retval = exec(	"ssh $ssh_user\@$server $command_string");
}else {
	print "$server is not accessible\n";

}#else
