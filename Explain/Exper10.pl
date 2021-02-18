#!/usr/bin/perl -w

use strict;

use vars qw ();
my $gold_d = "/home/jibmaird/Data/Experiments/Mutation/2";
my $partial_d = "/home/jibmaird/Data/Experiments/Mutation/1";

my $exp_d = "/home/jibmaird/Data/Experiments/Mutation/10";

#Process train sentences (extract sentences and their annotations)
#system("./train_sentences.pl $gold_d"); #It requires python37
#system("./train_sentences.pl $partial_d"); #It requires python37

#system("./identify_errors.pl $exp_d/conll_residual/out.txt $exp_d");

#system("./corenlp_server.pl");
#system("./align.pl $exp_d");
#DEBUG
#system("./align_count.pl $exp_d");


#get results from deeptorch
#system("scp dmiraola\@deep-torch.sl.cloud9.ibm.com:/home/dmiraola/Data/Experiments/Mutation/10/log.txt $exp_d");

#my $top = 20;
my @F = ("20","10","5");

foreach my $top (@F) {
#    system("./top_matches.pl $exp_d $top > $exp_d/top_matches.$top.txt");
    
    system("./eval_sent_identification.pl $exp_d/top_matches.$top.txt > $exp_d/eval.$top.txt");
}
