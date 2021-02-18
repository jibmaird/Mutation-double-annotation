#!/usr/bin/perl -w

use strict;

use vars qw ();

#my $log_f = "/home/jibmaird/Projects/biobert-pretrained/biobert_v1.0_pubmed/training-rZBJalxZg/top_matches.txt";
my $log_f = $ARGV[0];
my $out_d = $ARGV[1];

my $full_tsv = "/home/jibmaird/Data/Experiments/Mutation/8/conll_residual/train.tsv";
my $part_tsv = "/home/jibmaird/Data/Experiments/Mutation/10/conll_residual/train.tsv";

#read modified sentences as no-space keys
open(I,"$log_f")||die;
undef my %H;
while(<I>) {
    chomp;
    if (s/^\tSentence\: //) {
	s / //g;
	$H{$_} = 1;
    }
}
close(I);

#read final-annotated tsv, and link to identified sentences

open(I,$full_tsv)||die;
my $sent = "";
undef my @S;
while(<I>) {
    chomp;
    if ($_ eq "") {
	if (defined $H{$sent}) {
	    $H{$sent} = join "\n",@S;
	}
	$sent = "";
	undef @S;
    }
    else {
	/^(.*?)\t/;
	$sent = "$sent$1";
	push @S,$_;
    }
}
close(I);

#read partial annotated tsv, for each sentence: if identified copy final-annotated, otherwise print original 

open(O,">$out_d/conll_residual/train.tsv")||die;

open(I,$part_tsv)||die;
$sent = "";
undef @S;
my $orig = 0;
my $change = 0;
my $change_correct = 0;
while(<I>) {
    chomp;
    if ($_ eq "") {
	if (defined $H{$sent}) {
	    print O "$H{$sent}\n\n";
	    $change++;
	    $_ = join "\n",@S;
	    if ($_ ne $H{$sent}) {
		$change_correct++;
	    }
	}
	else {
	    $_ = join "\n",@S;
	    print O "$_\n\n";
	    $orig++;
	}
	$sent = "";
	undef @S;
    }
    else {
	/^(.*?)\t/;
	$sent = "$sent$1";
	push @S,$_;
    }
}
close(I);
close(O);
print "KEEP: $orig\n";
print "CHANGE: $change ";
$_ = $change / ($change+$orig);
printf("\(%1.2f\)\n",$_);
print "CHANGE CORRECT: $change_correct ";
$_ = $change_correct / $change;
printf("\(%1.2f\)\n",$_);
