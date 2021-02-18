#!/usr/bin/perl -w

# Use python37

use strict;

use vars qw ();

my $BIOBERT_DIR = "/home/jibmaird/Projects/biobert-pretrained/biobert_v1.0_pubmed";

#Exper 3
my $model_d = "training-7z7h6IsWR";
my $model_f = "model.ckpt-52";
my $NER_DIR = "/home/jibmaird/Data/Experiments/Mutation/3/bio";

#Exper 2
#my $model_d = "training-rZBJalxZg";
#my $model_f = "model.ckpt-260";
#my $NER_DIR = "/home/jibmaird/Data/Experiments/Mutation/2/bio";

#Exper 1
#my $model_d = "training-kR3c_I-Wg";
#my $model_f = "model.ckpt-270";
#my $NER_DIR = "/home/jibmaird/Data/Experiments/Mutation/1/bio";

#test
chdir("/home/jibmaird/Projects/biobert");
system("python run_ner.py --do_train=false --do_predict=true --do_eval=true --vocab_file=$BIOBERT_DIR\/vocab.txt --bert_config_file=$BIOBERT_DIR\/bert_config.json --init_checkpoint=$BIOBERT_DIR/$model_d/$model_f --data_dir=$NER_DIR\/ --output_dir=$BIOBERT_DIR/$model_d");

#eval entity-level
system("python biocodes/ner_detokenize.py --token_test_path=$BIOBERT_DIR/$model_d/token_test.txt --label_test_path=$BIOBERT_DIR/$model_d/label_test.txt --answer_path=$NER_DIR/test.tsv --output_dir=$BIOBERT_DIR/$model_d");
system("perl ./biocodes/conlleval.pl < $BIOBERT_DIR/$model_d/NER_result_conll.txt > $BIOBERT_DIR/$model_d/eval_entity.txt");
