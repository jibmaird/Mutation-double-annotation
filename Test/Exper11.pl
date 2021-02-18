#!/usr/bin/perl -w

use strict;

use vars qw ();


my $data_d = "/home/jibmaird/Data/Experiments/Mutation/11/conll_residual";
my $emb_f = "$data_d/embed_filter.txt";

my $lstm_d = "/home/jibmaird/Projects/ADE/EntityExtraction/Tools/residual-lstm-Antonio";
chdir($lstm_d);

#system("python annotate.py --model=$lstm_d\/models\/test_model_True_False_87006\/ --input=$data_d\/test.tsv > $data_d/out.txt");
system("python annotate.py --model=$lstm_d\/models\/test_model_True_False_2645\/ --input=$data_d\/test.tsv > $data_d/out.txt");


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
