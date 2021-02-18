#!/usr/bin/perl -w

use strict;
use vars qw ();

my $h=$ENV{'HOME'};

chdir("/home/dmiraola/biobert");

my $target_exp = 22;
my $reps = 20;

my $BIOBERT_DIR = "/aitu-stor/dmiraola/biobert_v1.0_pubmed_pmc";
#my $NER_DIR = "/aitu-stor/dmiraola/Experiments/Mutation/$target_exp";
my $NER_DIR = "$h/Data/Experiments/Mutation/$target_exp";

my @T = ("100","200","500");


if (not -e "$NER_DIR") {
    system("mkdir $NER_DIR");
}
if (not -e "$NER_DIR/bert_out") {
    system("mkdir $NER_DIR/bert_out");
}

for(my $i=1;$i<=$reps;$i++) {
    foreach my $t (@T) {

	if (not -e "$NER_DIR/bert_out/$t\_$i") {
	    system("mkdir $NER_DIR/bert_out/$t\_$i");
	}   
	
#	system("python run_ner.py --do_train=true --do_eval=true --vocab_file=$BIOBERT_DIR\/vocab.txt --bert_config_file=$BIOBERT_DIR\/bert_config.json --init_checkpoint=$BIOBERT_DIR\/biobert_model.ckpt --num_train_epochs=10.0 --data_dir=$NER_DIR\/bio\/$t\/ --output_dir=$NER_DIR/bert_out/$t\_$i");
#eval entity-level
#	system("python biocodes/ner_detokenize.py --token_test_path=$NER_DIR/bert_out/$t\_$i/token_test.txt --label_test_path=$NER_DIR/bert_out/$t\_$i/label_test.txt --answer_path=$NER_DIR/bio/$t/test.tsv --output_dir=$NER_DIR/bert_out/$t\_$i");
#	system("perl ./biocodes/conlleval.pl < $NER_DIR/bert_out/$t\_$i/NER_result_conll.txt > $NER_DIR/bert_out/$t\_$i/eval_entity.txt");

#download from aitu
#	system("scp -r dmiraola\@aitu.sl.cloud9.ibm.com:/home/dmiraola/Data/Experiments/Mutation/$target_exp/bert_out/$t\_$i/eval_entity.txt $NER_DIR/bert_out/$t\_$i");


    }
}

#system("./eval_avg_var.pl $NER_DIR/bert_out");
chdir("$h/aitu-ner-data-consistency/Test");
system("./eval_avg_var.pl $NER_DIR/bert_out $reps > $NER_DIR/eval.txt");
