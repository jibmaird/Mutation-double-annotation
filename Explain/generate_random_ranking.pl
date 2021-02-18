#!/usr/bin/perl -w

use List::Util 'shuffle';

use strict;

use vars qw ();

my $out_d = $ARGV[0];
my $data_d = "/home/jibmaird/Data/Experiments/Mutation/1/Train-sent";

open(O,">$out_d/random_ranking.txt")||die;

opendir(D,$data_d)||die;
my @File = grep /\d/,readdir D;
closedir(D);

@File = shuffle(@File);

foreach my $f (@File) {
    open(I,"$data_d/$f")||die;

    while(<I>) {
	chomp;
	
	s / //g;
	print O "$_\n";
    }
    close(I);

}
close(O);
