#!/usr/bin/perl -w

use strict;

use vars qw ();

#my $gold_d = "/home/jibmaird/Data/Experiments/Mutation/1";
my $exp_d = "/home/jibmaird/Data/Experiments/Mutation/6";

#Process train sentences (extract sentences and their annotations)
#system("./train_sentences.pl $gold_d"); #It requires python37
#system("./train_sentences.pl $exp_d"); #It requires python37

#system("./identify_errors.pl $exp_d/test1_output.txt $exp_d");

#system("./corenlp_server.pl");
#system("./align.pl $exp_d");

#system("./top_matches.pl $exp_d 10 > $exp_d/top_matches.txt");

system("./eval.pl $exp_d/top_matches.txt");
