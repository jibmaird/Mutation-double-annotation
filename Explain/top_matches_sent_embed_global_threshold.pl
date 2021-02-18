#!/usr/bin/perl -w

use strict;

use vars qw ();

my $log_d = $ARGV[0];

#my $top_matches = 5;
#my $log_d = "/home/jibmaird/Projects/biobert-pretrained/biobert_v1.0_pubmed/training-rZBJalxZg";

my $train_d = "/home/jibmaird/Data/Experiments/Mutation/1/Train-sent";
my $ann_d = "/home/jibmaird/Data/Experiments/Mutation/1/Train-sent-ann";
my $log_f = "$log_d/sentemb_log.txt";

#read training annotations
undef my %Ann;
opendir(D,"$train_d")||die;
my @File = grep /\.txt/,readdir D;
closedir(D);
foreach my $f (@File) {
    open(I,"$train_d/$f")||die;
    my $sent = "";
    while(<I>) {
	chomp;
	$sent = $_;
    }
    close(I);
    open(I,"$ann_d/$f")||die;
    while(<I>) {
	chomp;
	$Ann{$sent} = $_;
    }
    close(I);
}

#read errors
undef my %E;
open(I,"$log_d/errors.txt")||die;
open(I2,"$log_d/errors_id.txt")||die;
open(I3,"$log_d/errors_tokens.txt")||die;
while(<I>) {
    chomp;
    my $id = <I2>;
    chomp($id);
    my $aux = <I3>;
    chomp($aux);
    $E{$id} = "$_\nPrediction: $aux";
}
close(I);
close(I2);
close(I3);

open(I,"$log_f")||die;
undef my %H;
my $comp = "";
my $exp = "";
while(<I>) {
    chomp;
    my @F = split(/ /,$_);
    $H{$F[0]} = $F[2];
}
close(I);

foreach my $s1 (sort {$H{$b}<=>$H{$a}} keys %H) {

    open(I,"$train_d/$s1")||die "$train_d/$s1";
    my $sent = "";
    while(<I>) {
	chomp;
	$sent = $_;
    }
    close(I);
    
    $sent =~s / //g;
    print "$H{$s1} $sent\n";
    
}
