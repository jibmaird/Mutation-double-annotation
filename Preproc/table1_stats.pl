#!/usr/bin/perl -w

use strict;

use vars qw ();

my $data_d = "/home/jibmaird/Data/Experiments/Mutation";

my %Files =
    (
     "8/conll_residual/train.tsv"=>"train_adj",
     "8/conll_residual/devel.tsv"=>"devel_adj",
     "8/conll_residual/test.tsv"=>"test1",
     "10/conll_residual/train.tsv"=>"train_pre",
     "10/conll_residual/devel.tsv"=>"devel_pre",
     "11/conll_residual/test.tsv"=>"test2"
    );


undef my %R;
foreach my $f (keys %Files) {
    my $s = 0;
    my $m = 0;
    open(I,"$data_d/$f")||die;
    while(<I>) {
	chomp;
	if ($_ eq "") {
	    $s++;
	}
	else {
	    my @F = split(/\t/,$_);
	    if ($F[3]=~/\-Mutation$/) {
		$m++;
	    }
	}
    }
    close(I);
    $R{$Files{$f}}{s} = $s;
    $R{$Files{$f}}{m} = $m;
    
}

print "Training \& $R{train_adj}{s} \& $R{train_pre}{m} \& $R{train_adj}{m}\\\\\n";
print "Development \& $R{devel_adj}{s} \& $R{devel_pre}{m} \& $R{devel_adj}{m}\\\\\n";
print "Test-held-out (test1) \& $R{test1}{s} \& \- \& $R{test1}{m}\\\\\n";
print "Test (test2) \& $R{test2}{s} \& \- \& $R{test2}{m}\\\\\n";
