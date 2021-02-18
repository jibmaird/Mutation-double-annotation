#!/usr/bin/perl -w

use strict;

use vars qw ();

#my $log_f = "/home/jibmaird/Projects/biobert-pretrained/biobert_v1.0_pubmed/training-rZBJalxZg/top_matches.txt";
my $log_f = $ARGV[0];
my $out_d = $ARGV[1];
my $thr = $ARGV[2];

my $h = $ENV{'HOME'};


#read modified sentences as no-space keys
open(I,"$log_f")||die;
undef my %H;
my $i = 0;
while(<I>) {
    chomp;

    s /^.*? //;
    $H{$_} = 1;
    $i++;
    last if $i == $thr;
}
close(I);

my @Tr_dev = ("devel","train_dev");

my $orig = 0;
my $change = 0;
my $change_correct = 0;

# For both training and devel
foreach my $tr_dev (@Tr_dev) {

    my $full_tsv = "$h/Data/Experiments/Mutation/14/bio/$tr_dev.tsv";
    my $part_tsv = "$h/Data/Experiments/Mutation/15/bio/$tr_dev.tsv";

    #read final-annotated tsv, and link to identified sentences
    open(I,$full_tsv)||die "$full_tsv\n";
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
    open(O,">$out_d/$tr_dev\.tsv")||die;
    
    open(I,$part_tsv)||die;
    $sent = "";
    undef @S;

    while(<I>) {
	chomp;
	if ($_ eq "") {
	    # if target sentence then print final version (from %H) otherwise print current version (from $part_tsv)
	    if (defined $H{$sent}) {
#	    if ((defined $H{$sent})&&($change < $thr)) {
		print O "$H{$sent}\n\n";
		$change++;
		$_ = join "\n",@S;
		if ($_ ne $H{$sent}) {
		    $change_correct++;
		}
	    }
	    else {
		#print partial annotation
		$_ = join "\n",@S;
		print O "$_\n\n";
		$orig++;
	    }
	    $sent = "";
	    undef @S;
	}
	else {
	    #keep reading
	    /^(.*)\t/;
	    $sent = "$sent$1";
	    push @S,$_;
	}
    }
    close(I);
    close(O);
}


print "KEEP: $orig\n";
print "CHANGE: $change ";
$_ = $change / ($change+$orig);
printf("\(%1.2f\)\n",$_);
print "CHANGE CORRECT: $change_correct ";
$_ = $change_correct / $change;
printf("\(%1.2f\)\n",$_);
