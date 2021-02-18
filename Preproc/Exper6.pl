#!/usr/bin/perl -w

use strict;

use vars qw ();

use List::Util qw/shuffle/;

my $data_d = "/home/jibmaird/Data/Experiments/Mutation";

my $exp = 6;

if (not -e "$data_d/$exp") {
    system("mkdir $data_d/$exp");
    system("mkdir $data_d/$exp/conll_residual");
}
my %M = ("train"=>"train",
	 "train_dev"=>"devel",
	 "devel"=>"test");

foreach my $m (keys %M) {  
    open(I,"$data_d/2/conll/$m.tsv")||die;
    open(O,">$data_d/$exp/conll_residual/$M{$m}.tsv")||die;
    while(<I>) {
	chomp;
	
	my @F = split(/\t/,$_);
	if (defined $F[1]) {
	    print O "$F[3]\t.\t.\t$F[0]\n";
	}
	else {
	    print O "$_\n";
	}
    }

    close(I);
    close(O);

}

