#!/usr/bin/perl -w

use strict;

use vars qw ();

my $data_d = $ARGV[0];

opendir(D,$data_d)||die;
my @File = grep /\.tsv$/,readdir D;
closedir(D);

foreach my $f (@File) {
    open(I,"$data_d/$f")||die;
    open(O,">$data_d/$f~")||die;
    while(<I>) {
	chomp;
	if (/^[BI]\-/) {
	    s /^([BI])-.*?\_Mutation/$1\-Mutation/;
	    s /^([BI])-dbSNP/$1\-Mutation/;
	    if (not /^[BI]\-Mutation/) {
		s /[BI]\-.*?\t/O\t/;
	    }
	}
	print O "$_\n";
    }
    close(I);
    close(O);
    system("mv $data_d/$f~ $data_d/$f");
}
