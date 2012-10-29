#!/usr/bin/perl
################
######## binary_clock
##author: iltiscat
#mail:	schmiddim@gmx.at
#web:  	http://schmiddi.co.cc
#date:	08.10.09
#desc: 	a small script for conky shows the time  binary 
#use:	write ${execi 50 ~/.conky/binary_clock.pl} in your ~/.conkyrc
#	50 means the refresh intervall in seconds. 



my ($sec, $min, $hour, $mday, $month,
    $year, $day, $yearday, $dst) = localtime(time);

#split times
my @hour= split //, $hour;
my @min = split //, $min;

#dec to binary
if (@hour ==2){
	@h0 =split //, sprintf "% 04b", @hour[0];
	@h1 =split //, sprintf "% 04b", @hour[1];
} else {
	@h0=(0,0,0,0);
	@h1 =split //, sprintf "% 04b", @hour[0];
}#fi
if (@min ==2) {
	@m0 =split //,sprintf "% 04b", @min[0];
	@m1 =split //,sprintf "% 04b", @min[1];
} else {
	@m0 =(0,0,0,0);
	@m1 =split //,sprintf "% 04b", @min[0];
}#fi


#show me the time
print "|".@h0[0]."|".@h1[0]."| |".@m0[0]."|".@m1[0]."|\n";
print "|".@h0[1]."|".@h1[1]."|.|".@m0[1]."|".@m1[1]."|\n";
print "|".@h0[2]."|".@h1[2]."|.|".@m0[2]."|".@m1[2]."|\n";
print "|".@h0[3]."|".@h1[3]."| |".@m0[3]."|".@m1[3]."|\n";


