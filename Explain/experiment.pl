#!/usr/bin/perl -w

use strict;

use vars qw ();

my $gold_d = "/home/jibmaird/Data/Experiments/Mutation/2";
my $exp_d = "/home/jibmaird/Data/Experiments/Mutation/1";

#Process train sentences (extract sentences and their annotations)
#system("./train_sentences.pl $gold_d"); #It requires python37
#system("./train_sentences.pl $exp_d"); #It requires python37

#system("./identify_errors.pl");

#system("./corenlp_server.pl");
#system("./align.pl");

my $model_d = "/home/jibmaird/Projects/biobert-pretrained/biobert_v1.0_pubmed/training-rZBJalxZg";

#system("./top_matches.pl $model_d 12 > $model_d/top_matches.txt");

#system("./eval.pl $model_d/top_matches.txt");
