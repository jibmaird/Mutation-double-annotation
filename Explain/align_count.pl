#!/usr/bin/perl -w

use strict;

use vars qw ();

#read training (adjudicated data)
my $h = $ENV{"HOME"};
my $train_d = "$h/Data/Experiments/Mutation/1/Train-sent";
opendir(D,"$train_d")||die;
my @Train = grep /\.txt/,readdir D;
closedir(D);

#read test errors
my $error_d = $ARGV[0];
#my $error_d = "/home/jibmaird/Projects/biobert-pretrained/biobert_v1.0_pubmed/training-rZBJalxZg";

open(I1,"$error_d/errors.txt")||die;
my $cmp = 0;
while(<I1>) {
    foreach my $tr (@Train) {
	$cmp++;
    }
}
close(I1);
print "$cmp\n";
