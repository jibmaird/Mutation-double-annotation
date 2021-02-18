#!/usr/bin/perl -w

use strict;
use vars qw ();
#train

my $BIOBERT_DIR = "/aitu-stor/dmiraola/biobert_v1.0_pubmed_pmc";
my $NER_DIR = "/aitu-stor/dmiraola/Experiments/Mutation/14";

chdir("/home/dmiraola/biobert");

system("python run_ner.py --do_train=true --do_eval=true --vocab_file=$BIOBERT_DIR\/vocab.txt --bert_config_file=$BIOBERT_DIR\/bert_config.json --init_checkpoint=$BIOBERT_DIR\/biobert_model.ckpt --num_train_epochs=10.0 --data_dir=$NER_DIR\/bio\/ --output_dir=$NER_DIR/bert_out");
#eval entity-level
system("python biocodes/ner_detokenize.py --token_test_path=$NER_DIR/bert_out/token_test.txt --label_test_path=$NER_DIR/bert_out/label_test.txt --answer_path=$NER_DIR/bio/test.tsv --output_dir=$NER_DIR/bert_out");

system("perl ./biocodes/conlleval.pl < $NER_DIR/bert_out/NER_result_conll.txt > $NER_DIR/bert_out/eval_entity.txt");


