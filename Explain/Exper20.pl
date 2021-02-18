#!/usr/bin/perl -w

use strict;

use vars qw ();

my $exp_d = "/home/jibmaird/Data/Experiments/Mutation/20";

if (not -e "$exp_d") {
    system("mkdir $exp_d");
}

my @F = ("100","200","500");
# threshold
#my @F = ("498");

foreach my $t (@F) {
    for(my $i=1;$i<=5;$i++) {
	system("shuf $exp_d/../18/biobert_ranked.txt > $exp_d/random_ranked.txt");
	system("./eval_sent_identification_biobert.pl $exp_d/random_ranked.txt $t > $exp_d/eval_random.global$t.$i.txt");
    }
    system("./eval_avg_var.pl $exp_d $t");
}
