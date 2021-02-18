#!/usr/bin/perl -w

use strict;

use vars qw ();

my $exp = $ARGV[0];

my $h = $ENV{'HOME'};

my $data_d = "$h/Data/Experiments/Mutation/$exp/conll_residual";
#my $data_d = "$h/Data/Experiments/Mutation/$exp/bio/5";

my $emb_f = "$h/Data/Embeddings/medline-pmcoa.w2v.sg.w2v";

my $out_f = "$data_d/embed_filter.txt";

opendir(D,"$data_d")||die "$data_d\n";
my @File = grep /\.tsv/,readdir D;
closedir(D);
undef my %H;
foreach my $f (@File) {
    open(I,"$data_d/$f")||die;
    while(<I>) {
	if (/^(.*?)\t/) {
	    $H{$1} = 1;
	}
    }
    close(I);
}

open(I,"$emb_f")||die;
open(O,">$out_f")||die;
while(<I>) {
    /^(.*?) /;
    if (defined $H{$1}) {
	print O;
    }
}
close(I);
close(O);
