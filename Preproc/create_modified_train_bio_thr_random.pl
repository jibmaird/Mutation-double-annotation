#!/usr/bin/perl -w

use List::Util 'shuffle';

use strict;

use vars qw ();

#my $log_f = "/home/jibmaird/Projects/biobert-pretrained/biobert_v1.0_pubmed/training-rZBJalxZg/top_matches.txt";
my $out_d = $ARGV[0];
my $thr = $ARGV[1];

my $h = $ENV{'HOME'};

my $data_d = "$h/Data/Experiments/Mutation/1/Train-sent";


#read all sentences as no-space keys
opendir(D,"$data_d")||die;
my @File = grep /\.txt/,readdir D;
closedir(D);

@File = shuffle(@File);
#DEBUG
#print "$File[0]\n";

undef my %H;
my $i = 0;

foreach my $f (@File) {
    open(I,"$data_d/$f")||die;

    while(<I>) {
	chomp;
	
	s / //g;
	if (not defined $H{$_}) {
	    $H{$_} = 1;
	    $i++;
	}
    }
    close(I);
    last if $i == $thr;
}



#read final-annotated tsv, and link to identified sentences

my @Tr_dev = ("devel","train_dev");

my $orig = 0;
my $change = 0;
my $change_correct = 0;

foreach my $tr_dev (@Tr_dev) {

    my $full_tsv = "$h/Data/Experiments/Mutation/14/bio/$tr_dev.tsv";
    my $part_tsv = "$h/Data/Experiments/Mutation/15/bio/$tr_dev.tsv";

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
	    #if change required, use adjudicated labels from %H
	    if ((defined $H{$sent})&&($change < $thr)) {
		print O "$H{$sent}\n\n";
		$change++;
		$_ = join "\n",@S;
		if ($_ ne $H{$sent}) {
		    $change_correct++;
		}
	    }
	    else {
		#if no change required, use current analysis (partial)
		$_ = join "\n",@S;
		print O "$_\n\n";
		$orig++;
	    }
	    $sent = "";
	    undef @S;
	}
	else {
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
