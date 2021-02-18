#!/usr/bin/perl -w

use strict;

use vars qw ();
my $gold_d = "/home/jibmaird/Data/Experiments/Mutation/2";
my $partial_d = "/home/jibmaird/Data/Experiments/Mutation/1";

my $exp_d = "/home/jibmaird/Data/Experiments/Mutation/17";

if (not -e "$exp_d") {
    system("mkdir $exp_d");
}

#my @F = ("100","200","500");
# threshold
#DEBUG
my @F = ("1350");

foreach (@F) {
    system("./eval_sent_identification_benchmark.pl $exp_d/bilstm_ranked.txt $_ > $exp_d/eval_bilstm_confidence.global$_.txt");
}
