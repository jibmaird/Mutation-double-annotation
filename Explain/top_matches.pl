#!/usr/bin/perl -w

use strict;

use vars qw ();

my $log_d = $ARGV[0];
my $top_matches = $ARGV[1];

#my $top_matches = 5;
#my $log_d = "/home/jibmaird/Projects/biobert-pretrained/biobert_v1.0_pubmed/training-rZBJalxZg";

my $train_d = "/home/jibmaird/Data/Experiments/Mutation/1/Train-sent";
my $ann_d = "/home/jibmaird/Data/Experiments/Mutation/1/Train-sent-ann";
my $log_f = "$log_d/log.txt";

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
    if (/line no 0 computed with a score of (.*)$/) {
	my $sc = $1;
	if ($sc > 0) {
	    $comp =~ /^(.*?) (.*)$/;
	    $H{$1}{$2}{sc} = $sc;
	    $H{$1}{$2}{exp} = $exp;
	}
    }
    elsif (s/ Input file 1 loaded.//) {
	$comp = $_;
    }  
    elsif (/^\[.*\]$/) {
	$exp = $_;
    }
}
close(I);

foreach my $s1 (keys %H) {
    my $i = 0;
    print "Error in $s1\:$E{$s1}\nComments:\n\n";
    foreach my $s2 (sort {$H{$s1}{$b}{sc}<=>$H{$s1}{$a}{sc}} keys %{$H{$s1}}) {
	open(I,"$train_d/$s2")||die;
	my $sent = "";
	while(<I>) {
	    chomp;
	    $sent = $_;
	}
	close(I);
	print "\tSimilar sentence $i: $s2 Score: $H{$s1}{$s2}{sc} Matches: $H{$s1}{$s2}{exp}\n\tSentence: $sent\n\tGold labels: $Ann{$sent}\n\tManual labels:\n\tComments:\n\n";
	$i++;
	last if $i == $top_matches;
    }
}
