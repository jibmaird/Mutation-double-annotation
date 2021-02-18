#!/usr/bin/perl -w

use strict;

use vars qw ();

my $exp = 5;

use List::Util qw/shuffle/;

my $data_d = "/home/jibmaird/Data/Experiments/Mutation";

if (not -e "$data_d/$exp") {
    system("mkdir $data_d/$exp");
    system("mkdir $data_d/$exp/conll_residual");
}
my %M = ("train"=>"train",
	 "train_dev"=>"devel",
	 "test"=>"test");

foreach my $m (keys %M) {  
    open(I,"$data_d/1/conll/$m.tsv")||die;
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

