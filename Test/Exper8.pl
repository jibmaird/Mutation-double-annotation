#!/usr/bin/perl -w

use strict;

use vars qw ();


my $data_d = "/home/jibmaird/Data/Experiments/Mutation/8/conll_residual";
#my $emb_f = "/home/jibmaird/Data/Embeddings/medline-pmcoa.w2v.sg.w2v";
#my $emb_f = "/home/jibmaird/Data/Embeddings/medline-pmcoa.low.sg.w2v.filter";
my $emb_f = "$data_d/embed_filter.txt";

#my $lstm_d = "/home/jibmaird/Projects/ADE/EntityExtraction/Tools/residual-lstm";
my $lstm_d = "/home/jibmaird/Projects/ADE/EntityExtraction/Tools/residual-lstm-Antonio";
chdir($lstm_d);

#system("python train.py -f 1 -m 0 --withLM 0 -w 100 --pre_emb $emb_f --train $data_d\/train.tsv --dev $data_d\/devel.tsv --test $data_d\/test.tsv > $data_d/log_train.txt");
#system("mkdir $data_d/temp");
#system("mv $lstm_d/evaluation/temp/* $data_d/temp/");

#system("python annotate.py --model=$lstm_d\/models\/test_model_True_False_92162\/ --input=$data_d\/test.tsv > $data_d/log.txt");
#system("python tagger.py --model=$lstm_d\/models\/test_model_True_False_92162\/ --input=$data_d\/test.tsv");
#system("python evaluate.py --model=/home/jibmaird/Projects/ADE/EntityExtraction/Tools/residual-lstm\/models\/test_model_True_False_92162 --train=$data_d\/train.tsv --dev=$data_d\/devel.tsv --test=$data_d\/test.tsv");


#my $result_f = "/home/jibmaird/Projects/ADE/EntityExtraction/Tools/residual-lstm/evaluation/temp/eval.1131630.output";
#system("$lstm_d/evaluation/conlleval < $result_f");
#system("cp $result_f $data_d/../test1_output.txt");


#Repeat run with trained model

system("python annotate.py --model=$lstm_d\/models\/test_model_True_False_92162\/ --input=$data_d\/test.tsv > $data_d/out.txt");


#remove confidence scores
open(I,"$data_d/out.txt")||die;
open(O,">$data_d/out.txt~")||die;
while(<I>) {
    if ((not /^[\d \]\[]+$/)&&(not /^\d+\.\d+$/)) {
	print O;
    }
}
close(I);
close(O);
system("mv $data_d/out.txt~ $data_d/out.txt");
system("$lstm_d/evaluation/conlleval < $data_d/out.txt > $data_d/eval.txt");
