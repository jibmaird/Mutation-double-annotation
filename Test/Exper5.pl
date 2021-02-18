#!/usr/bin/perl -w

use strict;

use vars qw ();

my $lstm_d = "/home/jibmaird/Projects/ADE/EntityExtraction/Tools/residual-lstm";

chdir($lstm_d);
my $data_d = "/home/jibmaird/Data/Experiments/Mutation/5/conll_residual";

system("python train.py --train=$data_d\/train.tsv --dev=$data_d\/devel.tsv --test=$data_d\/test.tsv > $data_d/log.txt");

#my $result_f = "/home/jibmaird/Projects/ADE/EntityExtraction/Tools/residual-lstm/evaluation/temp/eval.1131630.output";
#system("$lstm_d/evaluation/conlleval < $result_f");
#system("cp $result_f $data_d/../test1_output.txt");
