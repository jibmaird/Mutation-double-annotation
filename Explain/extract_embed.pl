#!/usr/bin/perl -w

use strict;

use vars qw ();

my $BERT_BASE_DIR = $ARGV[0];
my $exp_d = $ARGV[1];
my $model = $ARGV[2];

#For each sentence in training and test, extract the last layer from the trained model
#read training (adjudicated data)
my $h = $ENV{"HOME"};
my $train_d = "$h/Data/Experiments/Mutation/1/Train-sent";
opendir(D,"$train_d")||die;
my @Train = grep /\.txt/,readdir D;
closedir(D);

chdir("$h/Projects/biobert");

my $out_d = "$exp_d/Sentence-embed";
if (not -e $out_d) {
    system("mkdir $out_d");
}

foreach my $f (@Train) {
    print "$f\n";
    my $in_f = "$train_d/$f";
    my $out_f = "$out_d/$f";
#    system("python extract_features.py --input_file=$in_f --output_file=$out_f --vocab_file=$BERT_BASE_DIR/vocab.txt --bert_config_file=$BERT_BASE_DIR/bert_config.json --init_checkpoint=$model --layers=-1 --max_seq_length=128 --batch_size=8");
}

my $errors_f = "$exp_d/errors.txt";

if (not -e "$exp_d/Errors"){
    system("mkdir $exp_d/Errors");
}
if (not -e "$exp_d/Errors-embed"){
    system("mkdir $exp_d/Errors-embed");
}

open(I,"$errors_f")||die;
open(I2,"$exp_d/errors_id.txt")||die;


while(<I>) {
    my $i = <I2>;
    chomp($i);
    chomp;
    open(O,">$exp_d/Errors/$i.txt")||die;
    print O "$_\n";
    close(O);
#    system("python extract_features.py --input_file=$exp_d/Errors/$i.txt --output_file=$exp_d/Errors-embed/$i.txt --vocab_file=$BERT_BASE_DIR/vocab.txt --bert_config_file=$BERT_BASE_DIR/bert_config.json --init_checkpoint=$model --layers=-1 --max_seq_length=128 --batch_size=8");
}
close(I);
close(I2);
