#!/usr/bin/perl -w

use strict;

use vars qw ();

my $data_d = $ARGV[0];
my $in_d = "$data_d/conll";
my $out_d = "$data_d/bio";

if (not -e $out_d) {
    system("mkdir $out_d");
}

opendir(D,$in_d)||die;
my @File = grep /\w/,readdir D;
closedir(D);

foreach my $f (@File) {
    open(I,"$in_d/$f")||die;
    open(O,">$out_d/$f")||die;
    while(<I>) {
	chomp;
	my @F = split(/\t/,$_);
	if (/^([BI])\-Mutation/) {
	    print O "$F[3]\t$1\n";
	}
	elsif ($_ ne "") {
	    print O "$F[3]\tO\n";
	}
	else {
	    print O "$_\n";
	}
    }
    close(I);
    close(O);
}
