#!/usr/bin/perl -w

use strict;

use vars qw ();

# it needs to use all logits and logit of the best sequence

my $ann_f = "/home/jibmaird/Data/Experiments/Mutation/17/conll_residual/ann_log.txt";

my $test_tsv = "/home/jibmaird/Data/Experiments/Mutation/17/conll_residual/test.tsv";

my $out_f = "/home/jibmaird/Data/Experiments/Mutation/17/bilstm_ranked.txt";
open(O,">$out_f")||die;


#Rank sentences according to their lstm score
undef my %H;
my $sent = "";
open(S,"$ann_f")||die;
open(I,"$test_tsv")||die;
$_ = <S>;
while((defined $_)&&(not /^[\d\.]+$/)) {
    $_ = <S>;
}
my $sc = $_;
chomp($sc);
$_ = <S>;
chomp;
$sc = $sc / $_;

while(<I>) {
    chomp;
    if ($_ eq "") {
	$H{$sent} = $sc;
	$sent = "";
	$_ = <S>;
	while((defined $_)&&(not /^[\d\.]+$/)) {
	    $_ = <S>;
	}
	last if not defined $_;
	$sc = $_;
	chomp($sc);
	$_ = <S>;
	chomp;
	$sc = $sc / $_;

    }
    else {
	/^(.*?)\t/;
	$sent = "$sent$1";
    }
}
close(I);
close(S);

foreach my $s (sort {$H{$a}<=>$H{$b}} keys %H) {
    print O "$H{$s} $s\n";
}
close(O);
