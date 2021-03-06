#!/usr/bin/perl -w

use strict;

use vars qw ();

use List::Util qw/shuffle/;

my $data_d = "/home/jibmaird/Data/Experiments/Mutation";

if (not -e "$data_d/11") {
    system("mkdir $data_d/11");
    system("mkdir $data_d/11/conll_residual");
}
my %M = ("train"=>"train",
	 "train_dev"=>"devel",
	 "test"=>"test");

foreach my $m (keys %M) {  

    if ($m eq "test") {
	open(I,"$data_d/1/conll/$m.tsv")||die;
    }
    else {
	open(I,"$data_d/2/conll/$m.tsv")||die;
    }

    open(O,">$data_d/11/conll_residual/$M{$m}.tsv")||die;
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

system("./filter_embeddings.pl 11");
