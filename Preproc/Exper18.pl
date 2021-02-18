#!/usr/bin/perl -w

use strict;

use vars qw ();

my $h = $ENV{'HOME'};
my $data_d = "$h/Data/Experiments/Mutation";

if (not -e "$data_d/18") {
    system("mkdir $data_d/18");
    system("mkdir $data_d/18/bio");
}

#merge train/train_dev => test
#split devel (test1) => train/devel

my %M = ("devel"=>1,
	 "train_dev"=>1);

open(O,">$data_d/18/bio/test.tsv")||die;
foreach my $m (keys %M) {  
    open(I,"$data_d/15/bio/$m.tsv")||die;

    while(<I>) {
	chomp;
	
	print O "$_\n";
    }

    close(I);

}
close(O);

my $dev = 0;
my $tot = `wc -l $data_d/15/bio/test.tsv`;
$tot =~ /^(\d+)\s/;
my $thr = $1 * 2 / 3;

open(I,"$data_d/15/bio/test.tsv")||die;
open(O,">$data_d/18/bio/train_dev.tsv")||die;
my $i = 0;
while(<I>) {
    chomp;

    if (($_ eq "")&&($dev == 0)&&($i > $thr)) {
	print O "$_\n";
	close(O);
	open(O,">$data_d/18/bio/devel.tsv")||die;
	$dev = 1;
	next;
    }
    
    print O "$_\n";

    $i++;
}

close(I);
close(O);


