#!/usr/bin/perl -w

use strict;
use vars qw ();

use List::Util qw/shuffle/;

my $data_d = $ARGV[0];
my $split_d = $ARGV[1];
my $out_d = $ARGV[2];

if (not -e $out_d) {
    system("mkdir $out_d");}

opendir(D,"$split_d")||die;
my @File = grep /\.tsv/,readdir D;
closedir(D);
    
foreach my $f (@File) {
    open(I,"$split_d/$f")||die;
    open(O,">$out_d/$f")||die;
    while(<I>) {
	chomp;
	my $f2 = $_;

	if ($f =~ /^train/) {
	    open(I2,"$data_d/Train/$f2")||die "$data_d/Train/$f2\n";}
	else {
	    open(I2,"$data_d/Test/$f2")||die;}
	while(<I2>) {
	    print O "$_";
	}
	close(I2);
	print O "\n";
    }
    close(O);
    close(I);
}

