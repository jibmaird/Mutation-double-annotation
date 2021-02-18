#!/usr/bin/perl -w

use strict;

use vars qw ();

use List::Util qw/shuffle/;

my $data_d = "/home/jibmaird/Data/Experiments/Mutation";

if (not -e "$data_d/3") {
    system("mkdir $data_d/3");
    system("mkdir $data_d/3/bio");
    system("mkdir $data_d/3/conll");
}

my $T = "Test";
opendir(D,"$data_d/1/$T")||die;
my @File = grep /\.conll/,readdir D;
closedir(D);

@File = shuffle @File;

open(O,">$data_d/3/conll/train.tsv")||die;
my $i = 0;
foreach my $f (@File) {
    open(I,"$data_d/1/$T/$f")||die;
    while(<I>) {
	print O "$_";
    }
    close(I);
    if ($i == int($#File / 3)) {
	close(O);
	open(O,">$data_d/3/conll/train_dev.tsv")||die;
    }
    if ($i == int($#File * 2 / 3)) {
	close(O);
	open(O,">$data_d/3/conll/devel.tsv")||die;
    }

    $i++;
}
close(O);

open(O,">$data_d/3/conll/test.tsv")||die;
opendir(D,"$data_d/1/Train")||die;
@File = grep /\.conll/,readdir D;
closedir(D);
foreach my $f (@File) {
    open(I,"$data_d/1/Train/$f")||die;
    while(<I>) {
	print O "$_";
    }
    close(I);
}

system("./single_class.pl $data_d/3/conll");
system("./create_3_files.pl $data_d/3"); #for residual-lstm
system("./simple_BIO.pl $data_d/3");

#Upload into DLaaS

my $cloud_d = "biobert/NERdata/Mutation/3";
system("./aws_move_data.pl $data_d/3/bio $cloud_d");
