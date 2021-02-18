#!/usr/bin/perl -w

use strict;

use vars qw ();

my $data_d = "/home/jibmaird/Data/Experiments/Mutation";

#DEBUG
system("./create_modified_train_stats.pl $data_d/10/top_matches.10.txt $data_d/12");

#system("./create_modified_train.pl $data_d/10/top_matches.5.txt $data_d/12");
#system("./create_modified_train.pl $data_d/10/top_matches.10.txt $data_d/12");
#system("./create_modified_train.pl $data_d/10/top_matches.20.txt $data_d/12");

#system("cp $data_d/11/conll_residual/devel.tsv $data_d/12/conll_residual");
#system("cp $data_d/11/conll_residual/test.tsv $data_d/12/conll_residual");
#system("./filter_embeddings.pl 12");
