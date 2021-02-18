#!/usr/bin/perl -w

use strict;
use vars qw ();


chdir("/home/dmiraola/biobert");

my $BIOBERT_DIR = "/aitu-stor/dmiraola/biobert_v1.0_pubmed_pmc";
my $NER_DIR = "/aitu-stor/dmiraola/Experiments/Mutation/16";

my @T = ("5","10","20");

foreach my $t (@T) {
#    system("python run_ner.py --do_train=true --do_eval=true --vocab_file=$BIOBERT_DIR\/vocab.txt --bert_config_file=$BIOBERT_DIR\/bert_config.json --init_checkpoint=$BIOBERT_DIR\/biobert_model.ckpt --num_train_epochs=10.0 --data_dir=$NER_DIR\/bio\/$t\/ --output_dir=$NER_DIR/bert_out/$t");
#eval entity-level
    system("python biocodes/ner_detokenize.py --token_test_path=$NER_DIR/bert_out/$t/token_test.txt --label_test_path=$NER_DIR/bert_out/$t/label_test.txt --answer_path=$NER_DIR/bio/$t/test.tsv --output_dir=$NER_DIR/bert_out/$t");
#    system("perl ./biocodes/conlleval.pl < $NER_DIR/bert_out2/$t/NER_result_conll.txt > $NER_DIR/bert_out2/$t/eval_entity.txt");
}

