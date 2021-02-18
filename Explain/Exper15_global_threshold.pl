#!/usr/bin/perl -w

use strict;

use vars qw ();
my $h = $ENV{"HOME"};
my $gold_d = "$h/Data/Experiments/Mutation/2";
my $partial_d = "$h/Data/Experiments/Mutation/1";

my $exp_d = "$h/Data/Experiments/Mutation/15";

#Process train sentences (extract sentences and their annotations)
#system("./train_sentences.pl $gold_d"); #It requires python37
#system("./train_sentences.pl $partial_d"); #It requires python37

#system("./identify_errors.pl $exp_d/bert_out/NER_result_conll.txt $exp_d");

#system("./corenlp_server.pl");
#system("./align.pl $exp_d");
#DEBUG
#system("./align_count.pl $exp_d");


#get results from deeptorch
#system("scp dmiraola\@deep-torch.sl.cloud9.ibm.com:/home/dmiraola/Data/Experiments/Mutation/15/log.txt $exp_d");

#my @F = ("100","200","500");
# threshold
my @F = ("498");

system("./top_matches_global_threshold.pl $exp_d > $exp_d/ists_ranking.txt");

foreach (@F) {
    system("./eval_sent_identification_benchmark.pl $exp_d/ists_ranking.txt $_ > $exp_d/eval_ists.global$_.txt");
}
