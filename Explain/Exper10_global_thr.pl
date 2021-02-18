#!/usr/bin/perl -w

use strict;

use vars qw ();
my $gold_d = "/home/jibmaird/Data/Experiments/Mutation/2";
my $partial_d = "/home/jibmaird/Data/Experiments/Mutation/1";

my $exp_d = "/home/jibmaird/Data/Experiments/Mutation/10";


system("./top_matches_global_threshold.pl $exp_d > $exp_d/ists_ranking.txt");

my @F = ("101","201","501");
# threshold
#my @F = ("498");

foreach (@F) {
    system("./eval_sent_identification_benchmark.pl $exp_d/ists_ranking.txt $_ > $exp_d/eval_ists.global$_.txt");
}
