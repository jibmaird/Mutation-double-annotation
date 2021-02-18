#!/usr/bin/perl -w

use strict;

use vars qw ();

my $exp_d = "/home/jibmaird/Data/Experiments/Mutation/18";

#system("./top_ranked_sentences_biobert.pl $exp_d");

if (not -e "$exp_d") {
    system("mkdir $exp_d");
}

my @F = ("100","200","500");
# threshold
#my @F = ("498");

foreach (@F) {
    system("./eval_sent_identification_biobert.pl $exp_d/biobert_ranked.txt $_ > $exp_d/eval_biobert_confidence.global$_.txt");

#DEBUG
#    system("./eval_sent_identification_biobert.pl $exp_d/random_ranked.txt $_ > $exp_d/eval_random.global$_.txt");
}
