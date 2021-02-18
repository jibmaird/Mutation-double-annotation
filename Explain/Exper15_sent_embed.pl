#!/usr/bin/perl -w

use strict;

use vars qw ();
my $h = $ENV{"HOME"};
my $gold_d = "$h/Data/Experiments/Mutation/2";
my $partial_d = "$h/Data/Experiments/Mutation/1";

my $exp_d = "$h/Data/Experiments/Mutation/15";
my $biobert_d = "$exp_d/biobert_v1.0_pubmed_pmc";

if (not -e $exp_d) {
    system("mkdir $exp_d");
}

#get model from aitu
#system("scp -r dmiraola\@aitu.sl.cloud9.ibm.com:/aitu-stor/dmiraola/biobert_v1.0_pubmed_pmc $exp_d");
#get exper data from aitu
#system("scp -r dmiraola\@aitu.sl.cloud9.ibm.com:/aitu-stor/dmiraola/Experiments/Mutation/15/bert_out $exp_d");

#system("./identify_errors.pl $exp_d/bert_out/NER_result_conll.txt $exp_d");

#system("./extract_embed.pl $biobert_d $exp_d $exp_d/bert_out/model.ckpt-224");

#system("python compare_sentences.py $exp_d/Sentence-embed/ $exp_d/Errors-embed/ > $exp_d/sentemb_log.txt");

my @F = ("20","10","5");
foreach my $top (@F) {
#    system("./top_matches_sent_embed.pl $exp_d $top > $exp_d/top_matches.$top.txt");
    system("./eval_sent_identification.pl $exp_d/top_matches.$top.txt > $exp_d/eval.$top.txt");
}
