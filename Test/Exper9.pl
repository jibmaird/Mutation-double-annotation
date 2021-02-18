#!/usr/bin/perl -w

use strict;

use vars qw ();


my $data_d = "/home/jibmaird/Data/Experiments/Mutation/9/conll_residual";
my $emb_f = "$data_d/embed_filter.txt";

my $lstm_d = "/home/jibmaird/Projects/ADE/EntityExtraction/Tools/residual-lstm-Antonio";
chdir($lstm_d);

#system("python annotate.py --model=$lstm_d\/models\/test_model_True_False_1653\/ --input=$data_d\/test.tsv > $data_d/out.txt");

system("$lstm_d/evaluation/conlleval < $data_d/out.txt > $data_d/eval.txt");

