#!/usr/bin/perl -w

use strict;

use vars qw ();

my $data_d = $ARGV[0];

if (not -e "$ARGV[0]/conll3files") {
    system("mkdir $ARGV[0]/conll3files");
}

system("cat $data_d/conll/train.tsv $data_d/conll/train_dev.tsv > $data_d/conll3files/train.tsv");
system("cp $data_d/conll/test.tsv $data_d/conll3files/test.tsv");
system("cp $data_d/conll/devel.tsv $data_d/conll3files/devel.tsv");
