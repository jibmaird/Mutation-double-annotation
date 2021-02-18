#!/usr/bin/perl -w

use strict;

use vars qw ();

#my $log_f = "/home/jibmaird/Projects/biobert-pretrained/biobert_v1.0_pubmed/training-rZBJalxZg/top_matches.txt";
my $log_f = $ARGV[0];
my $out_d = $ARGV[1];

if (not -e $out_d) {
    system("mkdir $out_d");
}
if (not -e "$out_d/conll_residual") {
    system("mkdir $out_d/conll_residual");
}



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

undef my %NOTSIM;
open(I,$full_tsv)||die;
my $sent = "";
undef my @S;
while(<I>) {
    chomp;
    if ($_ eq "") {
	if (defined $H{$sent}) {
	    $H{$sent} = join "\n",@S;
	}
	else {
	    $NOTSIM{$sent} = join "\n",@S;
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
my $nochange=0;
my $nochange_samelabels=0;
my $nochange_difflabels=0;
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
	    $nochange++;
	    if ($NOTSIM{$sent} eq $_) {
		$nochange_samelabels++;
	    }
	    else {
		$nochange_difflabels++;
	    }
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
printf("\(%1.3f\)\n",$_);
print "PRECISION: $change_correct \/ $change \: ";
my $p = $change_correct / $change;
printf("\(%1.3f\)\n",$p);
print "KEEP SAME LABELS: $nochange_samelabels\n";
my $r = $change_correct / ($change_correct + $nochange_difflabels);
print "RECALL: $change_correct \/ $change_correct \+ $nochange_difflabels ";
printf("\(%1.3f\)\n",$r);
$_ = 2 * $p * $r / ($p + $r);
print "F-SCORE: ";
printf("%1.3f\n",$_);
