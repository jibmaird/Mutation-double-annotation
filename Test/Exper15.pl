#!/usr/bin/perl -w

use strict;
use vars qw ();
#train

my $h = $ENV{'HOME'};

#my $BIOBERT_DIR = "/biobert_v1.0_pubmed_pmc";
my $NER_DIR = "$h/Data/Experiments/Mutation/15/bio";
my $OUT_DIR = "$h/Data/Experiments/Mutation/15/biobert_out";

chdir("$h/Projects/biobert");

#system("python run_ner.py --do_train=true --do_eval=true --vocab_file=$BIOBERT_DIR\/vocab.txt --bert_config_file=$BIOBERT_DIR\/bert_config.json --init_checkpoint=$BIOBERT_DIR\/biobert_model.ckpt --num_train_epochs=10.0 --data_dir=$NER_DIR\/bio\/ --output_dir=$NER_DIR/bert_out");
#eval entity-level
system("python biocodes/ner_detokenize.py --token_test_path=$OUT_DIR/token_test.txt --label_test_path=$OUT_DIR/label_test.txt --answer_path=$NER_DIR/test.tsv --output_dir=$OUT_DIR/");

#system("perl ./biocodes/conlleval.pl < $NER_DIR/bert_out/NER_result_conll.txt > $NER_DIR/bert_out/eval_entity.txt");


