#!/usr/bin/perl -w

use strict;

use vars qw ();

#my $log_f = "/home/jibmaird/Data/Experiments/Mutation/17/bilstm_ranked.txt";

#read top-k ranking sentences as no-space keys (unique sentences)
#read final-annotated tsv (1331 sentences), and link annotated string to identified sentences
#read partial annotated tsv (1331 sentences), for each sentence if part of top-k ranking, then change and evaluate

my $log_f = $ARGV[0];
my $top = $ARGV[1];

my @Full = ("/home/jibmaird/Data/Experiments/Mutation/8/conll_residual/train.tsv",
	 "/home/jibmaird/Data/Experiments/Mutation/8/conll_residual/devel.tsv"
);
my @Part = ("/home/jibmaird/Data/Experiments/Mutation/10/conll_residual/train.tsv",
	 "/home/jibmaird/Data/Experiments/Mutation/10/conll_residual/devel.tsv"
);

#my $part_tsv = "/home/jibmaird/Data/Experiments/Mutation/10/conll_residual/train.tsv";

#read modified sentences as no-space keys
open(I,"$log_f")||die;
my $i = 0;
undef my %H;
while(<I>) {
    chomp;

    #DEBUG
    #if (/NosignificantdifferencewasfoundbetweentheLNsandtheprimarytum/) {
    #print;}

    s /^[\d\.]+ //;
    s / //g;
    $H{$_} = 1;
    $i++;
    last if $i == $top;
}
close(I);

#read final-annotated tsv, and link to identified sentences

undef my %NOTSIM;
foreach my $full_tsv (@Full) {
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
}


#read partial annotated tsv, for each sentence: if identified measure whether change was correct


my $orig = 0;
my $change = 0;
my $change_correct = 0;
my $nochange=0;
my $nochange_samelabels=0;
my $nochange_difflabels=0;

foreach my $part_tsv (@Part) {

    open(I,$part_tsv)||die;
    my $sent = "";
    undef my @S;
    
    
    while(<I>) {
	chomp;
	if ($_ eq "") {
	    $sent =~s / //g;
	    if (defined $H{$sent}) {
		$change++;
		$_ = join "\n",@S;
		if ($_ ne $H{$sent}) {
		    $change_correct++;
		}
		#DEBUG
		#delete $H{$sent};
	    }
	    else {
		#DEBUG
		#if ($sent =~ /NosignificantdifferencewasfoundbetweentheLNsandtheprimarytumor/) {
		 #   print;
		#}

		$_ = join "\n",@S;
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
	else { #add token to sentence
	    /^(.*?)\t/;
	    $sent = "$sent$1";
	    push @S,$_;
	}
    }
    close(I);
}

print "KEEP: $orig\n";
print "TO CHANGE: $change ";
$_ = $change / ($change+$orig);
printf("\(%1.3f\)\n",$_);
print "PRECISION: $change_correct \/ $change \: ";
my $p = $change_correct / $change;
printf("\(%1.3f\)\n",$p);
#print "TO KEEP UNCHANGED: $nochange_samelabels\n";
my $r = $change_correct / ($change_correct + $nochange_difflabels);
print "RECALL: $change_correct \/ $change_correct \+ $nochange_difflabels ";
printf("\(%1.3f\)\n",$r);
if ($p + $r == 0) {
    $_ = 0;}
else {
    $_ = 2 * $p * $r / ($p + $r);
}
print "F-SCORE: ";
printf("%1.3f\n",$_);
