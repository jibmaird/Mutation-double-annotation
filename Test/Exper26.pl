#!/usr/bin/perl -w

use strict;
use vars qw ();

my $h=$ENV{'HOME'};

chdir("/home/dmiraola/biobert");

my $target_exp = 26;
my $reps = 20;

my $BIOBERT_DIR = "/aitu-stor/dmiraola/biobert_v1.0_pubmed_pmc";
#my $NER_DIR = "/aitu-stor/dmiraola/Experiments/Mutation/$target_exp";
my $NER_DIR = "$h/Data/Experiments/Mutation/$target_exp";

if (not -e "$NER_DIR") {
    system("mkdir $NER_DIR");
}
if (not -e "$NER_DIR/bert_out") {
    system("mkdir $NER_DIR/bert_out");
}
for(my $i=1;$i<=$reps;$i++) {

    if (not -e "$NER_DIR/bert_out/$i") {
	system("mkdir $NER_DIR/bert_out/$i");
    }   
	
#    system("python run_ner.py --do_train=true --do_eval=true --vocab_file=$BIOBERT_DIR\/vocab.txt --bert_config_file=$BIOBERT_DIR\/bert_config.json --init_checkpoint=$BIOBERT_DIR\/biobert_model.ckpt --num_train_epochs=10.0 --data_dir=$NER_DIR\/bio\/ --output_dir=$NER_DIR/bert_out/$i");
#eval entity-level
#    system("python biocodes/ner_detokenize.py --token_test_path=$NER_DIR/bert_out/$i/token_test.txt --label_test_path=$NER_DIR/bert_out/$i/label_test.txt --answer_path=$NER_DIR/bio/test.tsv --output_dir=$NER_DIR/bert_out/$i");
#    system("perl ./biocodes/conlleval.pl < $NER_DIR/bert_out/$i/NER_result_conll.txt > $NER_DIR/bert_out/$i/eval_entity.txt");

#download from aitu
#	system("scp -r dmiraola\@aitu.sl.cloud9.ibm.com:/home/dmiraola/Data/Experiments/Mutation/$target_exp/bert_out/$i/eval_entity.txt $NER_DIR/bert_out/$i");


}

chdir("$h/aitu-ner-data-consistency/Test");
system("./eval_avg_var2.pl $NER_DIR/bert_out $reps > $NER_DIR/eval.txt");
