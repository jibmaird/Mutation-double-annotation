#!/usr/bin/perl -w

use strict;

use vars qw ();
my $h = $ENV{"HOME"};
my $gold_d = "$h/Data/Experiments/Mutation/2";
my $partial_d = "$h/Data/Experiments/Mutation/1";

my $exp_d = "$h/Data/Experiments/Mutation/15";
my $biobert_d = "$exp_d/biobert_v1.0_pubmed_pmc";

if (not -e $exp_d) {
    system("mkdir $exp_d");
}

#system("./top_matches_sent_embed_global_threshold.pl $exp_d > $exp_d/sent_embed_ranking.txt");

my @F = ("100","200","503");

foreach (@F) {
    system("./eval_sent_identification_benchmark.pl $exp_d/sent_embed_ranking.txt $_ > $exp_d/eval_sent_emb.global$_.txt");
}
