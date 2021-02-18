#!/usr/bin/perl -w

use strict;

use vars qw ();


my $data_d = "/home/jibmaird/Data/Experiments/Mutation/12/conll_residual";
#my $emb_f = "/home/jibmaird/Data/Embeddings/medline-pmcoa.w2v.sg.w2v";
#my $emb_f = "/home/jibmaird/Data/Embeddings/medline-pmcoa.low.sg.w2v.filter";
my $emb_f = "$data_d/embed_filter.txt";

#my $lstm_d = "/home/jibmaird/Projects/ADE/EntityExtraction/Tools/residual-lstm";
my $lstm_d = "/home/jibmaird/Projects/ADE/EntityExtraction/Tools/residual-lstm-Antonio";
chdir($lstm_d);

system("python train.py -f 1 -m 0 --withLM 0 -w 100 --pre_emb $emb_f --train $data_d\/train.tsv --dev $data_d\/devel.tsv --test $data_d\/test.tsv > $data_d/log_train.tmp.txt");
#system("mkdir $data_d/temp");
#system("mv $lstm_d/evaluation/temp/* $data_d/temp/");


#evaluate top-10 matches
#system("python evaluate.py --model=/home/jibmaird/Projects/ADE/EntityExtraction/Tools/residual-lstm-Antonio\/models\/test_model_True_False_64438 --train=$data_d\/train.tsv --dev=$data_d\/devel.tsv --test=$data_d\/test.tsv");

#evaluate top-5 matches
#system("python evaluate.py --model=/home/jibmaird/Projects/ADE/EntityExtraction/Tools/residual-lstm-Antonio\/models\/test_model_True_False_41552 --train=$data_d\/train.tsv --dev=$data_d\/devel.tsv --test=$data_d\/test.tsv");


#my $result_f = "$data_d/temp/eval.1992023.output";
#system("$lstm_d/evaluation/conlleval < $result_f");
#system("cp $result_f $data_d/../test1_output.txt");
