#!/usr/bin/perl -w

my $h = $ENV{'HOME'};

my $adj = "$h/Data/Experiments/Mutation/1";
my $data_d = "$h/Data/Experiments/Mutation/27";

if (not -e $data_d) {
    system("mkdir $data_d");
}

system("cp -r $adj/conll $data_d/conll");
system("./simple_BIO.pl $data_d");
system("mv $data_d/bio/devel.tsv $data_d/bio/test.tsv");
system("mv $data_d/bio/train_dev.tsv $data_d/bio/devel.tsv");
system("mv $data_d/bio/train.tsv $data_d/bio/train_dev.tsv");

