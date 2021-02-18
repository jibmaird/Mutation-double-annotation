#!/usr/bin/perl -w

use strict;

use vars qw ();

#my $h = $ENV{'HOME'};
#my $data_d = "$h/Data/Experiments/Mutation/18";

my $data_d = $ARGV[0];

#read training sentences
undef my %H;
my @Full = ("/home/jibmaird/Data/Experiments/Mutation/8/conll_residual/train.tsv",
	 "/home/jibmaird/Data/Experiments/Mutation/8/conll_residual/devel.tsv"
);
foreach my $full_tsv (@Full) {
    open(I,$full_tsv)||die;
    my $sent = "";
    while(<I>) {
	chomp;
	if ($_ eq "") {
	    #DEBUG
	    #if ($sent=~/Ourresultsindicatethat/) {
		#print;}
	    $H{$sent} = 0;
	    $sent = "";
	}
	else {
	    /^(.*?)\t/;
	    $sent = "$sent$1";
	}
    }
    close(I);
}

open(I,"$data_d/bert_out/token_test.txt")||die;
open(L,"$data_d/bert_out/logits_test.txt")||die;
open(O,">$data_d/biobert_ranked.txt")||die;

my $s = "";
undef my @L;
while(<I>) {
    chomp;
    my $l = <L>;
    chomp($l);
    if (/^\[SEP\]$/) {
	if (defined $H{$s}) {
	    $H{$s} = &logit_score(@L);
	    $s = "";
	    undef @L;
	}
	else {
	    #DEBUG
	    #if ($s=~/Ourresultsindicatethat/) {
		#print;}
	    next;
	}
    }
    elsif (/^\[CLS\]$/) {
	next;
    }
    elsif (/^\[UNK\]$/) {
	$s = "$s\∼";
	push @L,$l;
	next;
    }
    else {
	s /\#\#//;
	$s = "$s$_";
	push @L,$l;
    }
}
close(I);
close(L);

foreach (sort {$H{$a}<=>$H{$b}} keys %H) {
    print O "$H{$_} $_\n";
}
close(O);

sub logit_score {

#Calculate confidence as p(i)/sum(p(i)) where p(i) refers to the logit output,  i = 1, 2, ..., N and N is the number of classes.
#For sequence tagging, I think maybe you can calculate the confidence score for each position, and average over all positions.

    my @L = @_;
    my $i = 0;
    my $tot = 1;
    foreach my $l (@L) {
	my @F = split(/\s+/,$l);
	my $sum = 0;
	foreach (@F) {
	    $sum += $_;
	}
	my $max = 0;
	foreach (@F) {
	    my $c = $_ / $sum;
	    if ($c > $max) {
		$max = $c;
	    }
	}
	$tot *= $max;
#DEBUG
#	$tot++;

    }


    return $tot;

}
