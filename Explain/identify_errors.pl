#!/usr/bin/perl -w

use strict;

use vars qw ();

my $in_f = $ARGV[0];
my $result_d = $ARGV[1];
#my $result_d = "/home/jibmaird/Projects/biobert-pretrained/biobert_v1.0_pubmed/training-rZBJalxZg";
#open(I,"$result_d/NER_result_conll.txt");

open(I,$in_f)||die;

open(O,">$result_d/errors.txt")||die;
open(O2,">$result_d/errors_id.txt")||die;
open(O3,">$result_d/errors_tokens.txt")||die;

my $i = 0;
undef my %H;
undef my @Sent;
while(<I>) {
    chomp;
    if ($_ eq "") {
	if (defined $H{$i}) {
	    $_ = join " ",@Sent;
	    print O "$_\n";
	    print O2 "$i\n";
	    $_ = join " ",@{$H{$i}};
	    s /\-MISC//g;
	    print O3 "$_\n";
	}
	$i++;
	undef @Sent;
    }
    else {
	s / \. \. / /;
	my @F = split(/ /,$_);
	if ($F[1] ne $F[2]) {
	    push @{$H{$i}},"$F[0]\#$F[2]";
	}
	push @Sent,$F[0];
    }
}
close(I);
close(O);
close(O2);
close(O3);
