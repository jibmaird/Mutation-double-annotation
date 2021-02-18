#!/usr/bin/perl -w

use strict;

use vars qw ();

my $data_d = "/home/jibmaird/Data/Experiments/Mutation";

if (not -e "$data_d/17") {
    system("mkdir $data_d/17");
    system("mkdir $data_d/17/conll_residual");
}

#merge train/train_dev => test
#split devel (test1) => train/devel

my %M = ("train"=>1,
	 "train_dev"=>1);

open(O,">$data_d/17/conll_residual/test.tsv")||die;
foreach my $m (keys %M) {  
    open(I,"$data_d/1/conll/$m.tsv")||die;

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

}
close(O);

my $dev = 0;
my $tot = `wc -l $data_d/1/conll/devel.tsv`;
$tot =~ /^(\d+)\s/;
my $thr = $1 * 2 / 3;

open(I,"$data_d/1/conll/devel.tsv")||die;
open(O,">$data_d/17/conll_residual/train.tsv")||die;
my $i = 0;
while(<I>) {
    chomp;

    if (($_ eq "")&&($dev == 0)&&($i > $thr)) {
	print O "$_\n";
	close(O);
	open(O,">$data_d/17/conll_residual/devel.tsv")||die;
	$dev = 1;
	next;
    }
    
    my @F = split(/\t/,$_);
    if (defined $F[1]) {
	print O "$F[3]\t.\t.\t$F[0]\n";
    }
    else {
	print O "$_\n";
    }
    $i++;
}

close(I);
close(O);

system("./filter_embeddings.pl 17");
