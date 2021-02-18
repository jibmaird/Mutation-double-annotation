#!/usr/bin/perl -w

use strict;

use vars qw ();


my $data_d = "/home/jibmaird/Data/Experiments/Mutation/17/conll_residual";
my $emb_f = "$data_d/embed_filter.txt";

my $lstm_d = "/home/jibmaird/Projects/ADE/EntityExtraction/Tools/residual-lstm-Antonio";
chdir($lstm_d);

#system("python train.py -f 1 -m 0 --withLM 0 -w 100 --pre_emb $emb_f --train $data_d\/train.tsv --dev $data_d\/devel.tsv --test $data_d\/test.tsv > $data_d/log_train.txt");
#system("mkdir $data_d/temp");
#system("mv $lstm_d/evaluation/temp/* $data_d/temp/");

#obtain Viterbi and full prob
system("python annotate.py --model=$lstm_d\/models\/test_model_True_False_39035\/ --input=$data_d\/test.tsv > $data_d/ann_log.txt");

#check evaluation results
#system("python evaluate.py --model=$lstm_d\/models\/test_model_True_False_39035 --train=$data_d\/train.tsv --dev=$data_d\/devel.tsv --test=$data_d\/test.tsv");


